import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/dtos/dtos.dart';
import 'package:medbook/features/clinical_reference/data/mappers/clinical_reference_mapper.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';

final class ClinicalReferenceSynchronizer {
  const ClinicalReferenceSynchronizer(
    this._remoteDataSource,
    this._localDataSource,
  );

  static const _mapper = ClinicalReferenceMapper();

  final ClinicalReferenceRemoteDataSource _remoteDataSource;
  final ClinicalReferenceLocalDataSource _localDataSource;

  Future<Either<Failure, SyncOutcome>> synchronize() async {
    final download = await _remoteDataSource.fetchClinicalReference();

    return download.match(
      _useCacheOrFailure,
      _validateAndStore,
    );
  }

  Future<Either<Failure, SyncOutcome>> _validateAndStore(
    ClinicalReferenceDto dto,
  ) async {
    final mappedDataset = _mapper.map(dto);

    return mappedDataset.match(
      _useCacheOrFailure,
      _store,
    );
  }

  Future<Either<Failure, SyncOutcome>> _store(
    ClinicalReferenceDataset dataset,
  ) async {
    try {
      await _localDataSource.replaceDataset(
        dataset: dataset,
        synchronizedAt: DateTime.now().toUtc(),
      );
      return const Right(SyncOutcome.updated);
    } on Exception {
      return _useCacheOrFailure(const LocalStorageFailure());
    }
  }

  Future<Either<Failure, SyncOutcome>> _useCacheOrFailure(
    Failure failure,
  ) async {
    try {
      if (await _localDataSource.hasCachedData()) {
        return const Right(SyncOutcome.usingCachedData);
      }

      return Left(failure);
    } on Exception {
      return const Left(LocalStorageFailure());
    }
  }
}
