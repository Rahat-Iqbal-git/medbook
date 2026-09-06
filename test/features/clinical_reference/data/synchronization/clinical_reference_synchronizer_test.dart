import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/dtos/dtos.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/data/synchronization/clinical_reference_synchronizer.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';

void main() {
  group('ClinicalReferenceSynchronizer', () {
    test('downloads, validates, and stores new data', () async {
      final local = _LocalDataSource();
      final synchronizer = _synchronizer(
        remoteResult: Right(_validDto()),
        local: local,
      );

      final result = await synchronizer.synchronize();

      _expectOutcome(result, SyncOutcome.updated);
      expect(local.storedDataset, isNotNull);
      expect(local.storedDataset!.medicines.single.id, 10);
      expect(local.storedDataset!.recommendations.single.medicineId, 10);
    });

    test('uses saved data when downloading fails', () async {
      final local = _LocalDataSource(hasCache: true);
      final synchronizer = _synchronizer(
        remoteResult: const Left(ConnectionFailure()),
        local: local,
      );

      final result = await synchronizer.synchronize();

      _expectOutcome(result, SyncOutcome.usingCachedData);
      expect(local.storedDataset, isNull);
    });

    test('returns the download failure when no saved data exists', () async {
      final synchronizer = _synchronizer(
        remoteResult: const Left(ConnectionFailure()),
        local: _LocalDataSource(),
      );

      final result = await synchronizer.synchronize();

      result.match(
        (failure) => expect(failure, isA<ConnectionFailure>()),
        (outcome) => fail('Expected a failure, got $outcome.'),
      );
    });

    test(
      'keeps saved data when the download is semantically invalid',
      () async {
        final local = _LocalDataSource(hasCache: true);
        final synchronizer = _synchronizer(
          remoteResult: Right(_validDto(version: 0)),
          local: local,
        );

        final result = await synchronizer.synchronize();

        _expectOutcome(result, SyncOutcome.usingCachedData);
        expect(local.storedDataset, isNull);
      },
    );

    test('keeps saved data when local replacement fails', () async {
      final local = _LocalDataSource(hasCache: true, failToReplace: true);
      final synchronizer = _synchronizer(
        remoteResult: Right(_validDto()),
        local: local,
      );

      final result = await synchronizer.synchronize();

      _expectOutcome(result, SyncOutcome.usingCachedData);
    });

    test('returns a storage failure when the first local save fails', () async {
      final synchronizer = _synchronizer(
        remoteResult: Right(_validDto()),
        local: _LocalDataSource(failToReplace: true),
      );

      final result = await synchronizer.synchronize();

      result.match(
        (failure) => expect(failure, isA<LocalStorageFailure>()),
        (outcome) => fail('Expected a failure, got $outcome.'),
      );
    });
  });
}

ClinicalReferenceSynchronizer _synchronizer({
  required Either<Failure, ClinicalReferenceDto> remoteResult,
  required _LocalDataSource local,
}) {
  return ClinicalReferenceSynchronizer(
    _RemoteDataSource(remoteResult),
    local,
  );
}

void _expectOutcome(
  Either<Failure, SyncOutcome> result,
  SyncOutcome expected,
) {
  result.match(
    (failure) => fail('Expected $expected, got ${failure.message}.'),
    (outcome) => expect(outcome, expected),
  );
}

ClinicalReferenceDto _validDto({int version = 1}) {
  return ClinicalReferenceDto(
    version: version,
    diseases: const [
      DiseaseDto(
        id: 1,
        name: 'Aster Respiratory Veil',
        category: 'Respiratory',
        keywords: ['respiratory', 'cough'],
      ),
    ],
    antibiotics: const [
      AntibioticDto(
        id: 10,
        name: 'Medicine Alpha',
        genericName: 'Formula A',
      ),
    ],
    recommendations: const [
      TreatmentRecommendationDto(
        id: 100,
        diseaseId: 1,
        antibioticId: 10,
        type: 'First Line',
        dose: '500 mg',
        frequency: 'Twice daily',
        duration: '5 days',
      ),
    ],
  );
}

final class _RemoteDataSource implements ClinicalReferenceRemoteDataSource {
  const _RemoteDataSource(this.result);

  final Either<Failure, ClinicalReferenceDto> result;

  @override
  Future<Either<Failure, ClinicalReferenceDto>> fetchClinicalReference() async {
    return result;
  }
}

final class _LocalDataSource implements ClinicalReferenceLocalDataSource {
  _LocalDataSource({this.hasCache = false, this.failToReplace = false});

  final bool hasCache;
  final bool failToReplace;
  ClinicalReferenceDataset? storedDataset;

  @override
  Future<ClinicalReferenceOverview> getOverview() async =>
      const ClinicalReferenceOverview(diseases: [], medicines: []);

  @override
  Future<bool> hasCachedData() async => hasCache;

  @override
  Future<DiseaseDetails?> getDiseaseDetails({required int id}) async => null;

  @override
  Future<MedicineDetails?> getMedicineDetails({required int id}) async => null;

  @override
  Future<List<ClinicalSearchResult>> search({required String query}) async {
    return const [];
  }

  @override
  Future<void> replaceDataset({
    required ClinicalReferenceDataset dataset,
    required DateTime synchronizedAt,
  }) async {
    if (failToReplace) {
      throw Exception('Local replacement failed.');
    }

    storedDataset = dataset;
  }
}
