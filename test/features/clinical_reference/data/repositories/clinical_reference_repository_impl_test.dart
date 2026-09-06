import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/dtos/dtos.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/data/repositories/clinical_reference_repository_impl.dart';
import 'package:medbook/features/clinical_reference/data/synchronization/clinical_reference_synchronizer.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';

void main() {
  group('ClinicalReferenceRepositoryImpl', () {
    test('uses the synchronizer cache fallback when download fails', () async {
      final result = await _repository(
        local: _LocalDataSource(hasCache: true),
        remoteResult: const Left(ConnectionFailure()),
      ).synchronize();

      result.match(
        (failure) => fail('Expected cached data, got ${failure.message}.'),
        (outcome) => expect(outcome, SyncOutcome.usingCachedData),
      );
    });

    test('returns saved search results', () async {
      const searchResult = ClinicalSearchResult(
        id: 1,
        type: ClinicalSearchResultType.disease,
        title: 'Aster Condition',
        subtitle: 'Respiratory',
      );
      final local = _LocalDataSource(searchResults: const [searchResult]);

      final result = await _repository(local: local).search(query: 'aster');

      result.match(
        (failure) => fail('Expected search results, got ${failure.message}.'),
        (results) => expect(results, [searchResult]),
      );
      expect(local.searchQuery, 'aster');
    });

    test('maps local search errors to a storage failure', () async {
      final result = await _repository(
        local: _LocalDataSource(failSearch: true),
      ).search(query: 'aster');

      result.match(
        (failure) => expect(failure, isA<LocalStorageFailure>()),
        (results) => fail('Expected a failure, got $results.'),
      );
    });

    test('returns saved disease details', () async {
      final details = DiseaseDetails(disease: _disease, treatments: const []);

      final result = await _repository(
        local: _LocalDataSource(diseaseDetails: details),
      ).getDiseaseDetails(id: 1);

      result.match(
        (failure) => fail('Expected details, got ${failure.message}.'),
        (value) => expect(value, same(details)),
      );
    });

    test('maps a missing disease to a not-found failure', () async {
      final result = await _repository(
        local: _LocalDataSource(),
      ).getDiseaseDetails(id: 404);

      result.match(
        (failure) {
          expect(failure, isA<NotFoundFailure>());
          expect(failure.message, 'Disease with ID 404 was not found.');
        },
        (details) => fail('Expected a failure, got $details.'),
      );
    });

    test('returns saved medicine details', () async {
      final details = MedicineDetails(
        medicine: _medicine,
        treatments: const [],
      );

      final result = await _repository(
        local: _LocalDataSource(medicineDetails: details),
      ).getMedicineDetails(id: 10);

      result.match(
        (failure) => fail('Expected details, got ${failure.message}.'),
        (value) => expect(value, same(details)),
      );
    });

    test('maps local medicine detail errors to a storage failure', () async {
      final result = await _repository(
        local: _LocalDataSource(failMedicineDetails: true),
      ).getMedicineDetails(id: 10);

      result.match(
        (failure) => expect(failure, isA<LocalStorageFailure>()),
        (details) => fail('Expected a failure, got $details.'),
      );
    });
  });
}

ClinicalReferenceRepositoryImpl _repository({
  required _LocalDataSource local,
  Either<Failure, ClinicalReferenceDto>? remoteResult,
}) {
  return ClinicalReferenceRepositoryImpl(
    ClinicalReferenceSynchronizer(
      _RemoteDataSource(remoteResult ?? const Left(ConnectionFailure())),
      local,
    ),
    local,
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
  _LocalDataSource({
    this.hasCache = false,
    this.searchResults = const [],
    this.diseaseDetails,
    this.medicineDetails,
    this.failSearch = false,
    this.failMedicineDetails = false,
  });

  final bool hasCache;
  final List<ClinicalSearchResult> searchResults;
  final DiseaseDetails? diseaseDetails;
  final MedicineDetails? medicineDetails;
  final bool failSearch;
  final bool failMedicineDetails;
  String? searchQuery;

  @override
  Future<ClinicalReferenceOverview> getOverview() async =>
      const ClinicalReferenceOverview(diseases: [], medicines: []);

  @override
  Future<DiseaseDetails?> getDiseaseDetails({required int id}) async {
    return diseaseDetails;
  }

  @override
  Future<MedicineDetails?> getMedicineDetails({required int id}) async {
    if (failMedicineDetails) {
      throw Exception('Could not read medicine details.');
    }

    return medicineDetails;
  }

  @override
  Future<bool> hasCachedData() async => hasCache;

  @override
  Future<void> replaceDataset({
    required ClinicalReferenceDataset dataset,
    required DateTime synchronizedAt,
  }) async {}

  @override
  Future<List<ClinicalSearchResult>> search({required String query}) async {
    if (failSearch) {
      throw Exception('Could not search saved data.');
    }

    searchQuery = query;
    return searchResults;
  }
}

const _disease = Disease(
  id: 1,
  name: 'Aster Condition',
  category: 'Respiratory',
  keywords: ['aster'],
);

const _medicine = Medicine(
  id: 10,
  name: 'Medicine Alpha',
  genericName: 'Formula A',
);
