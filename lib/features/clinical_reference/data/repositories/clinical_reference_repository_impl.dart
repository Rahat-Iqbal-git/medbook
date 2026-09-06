import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/synchronization/clinical_reference_synchronizer.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';

final class ClinicalReferenceRepositoryImpl
    implements ClinicalReferenceRepository {
  const ClinicalReferenceRepositoryImpl(
    this._synchronizer,
    this._localDataSource,
  );

  final ClinicalReferenceSynchronizer _synchronizer;
  final ClinicalReferenceLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, SyncOutcome>> synchronize() =>
      _synchronizer.synchronize();

  @override
  Future<Either<Failure, ClinicalReferenceOverview>> getOverview() async {
    try {
      return Right(await _localDataSource.getOverview());
    } on Exception {
      return const Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, List<ClinicalSearchResult>>> search({
    required String query,
  }) async {
    try {
      return Right(await _localDataSource.search(query: query));
    } on Exception {
      return const Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, DiseaseDetails>> getDiseaseDetails({
    required int id,
  }) async {
    try {
      final details = await _localDataSource.getDiseaseDetails(id: id);
      if (details == null) {
        return Left(
          NotFoundFailure(message: 'Disease with ID $id was not found.'),
        );
      }

      return Right(details);
    } on Exception {
      return const Left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, MedicineDetails>> getMedicineDetails({
    required int id,
  }) async {
    try {
      final details = await _localDataSource.getMedicineDetails(id: id);
      if (details == null) {
        return Left(
          NotFoundFailure(message: 'Medicine with ID $id was not found.'),
        );
      }

      return Right(details);
    } on Exception {
      return const Left(LocalStorageFailure());
    }
  }
}
