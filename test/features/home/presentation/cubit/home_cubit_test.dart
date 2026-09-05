import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';
import 'package:medbook/features/home/presentation/cubit/home_cubit.dart';

void main() {
  group('HomeCubit', () {
    blocTest<HomeCubit, HomeState>(
      'emits loading then ready when the dataset is updated',
      build: () => HomeCubit(
        const _ClinicalReferenceRepository(Right(SyncOutcome.updated)),
      ),
      act: (cubit) => cubit.synchronize(),
      expect: () => [isA<HomeLoading>(), isA<HomeReady>()],
    );

    blocTest<HomeCubit, HomeState>(
      'exposes the failure when the first synchronization cannot complete',
      build: () => HomeCubit(
        const _ClinicalReferenceRepository(Left(ConnectionFailure())),
      ),
      act: (cubit) => cubit.synchronize(),
      expect: () => [isA<HomeLoading>(), isA<HomeFailure>()],
    );

    blocTest<HomeCubit, HomeState>(
      'reports that saved data is being used when refresh falls back to cache',
      build: () => HomeCubit(
        const _ClinicalReferenceRepository(Right(SyncOutcome.usingCachedData)),
      ),
      act: (cubit) => cubit.synchronize(),
      expect: () => [
        isA<HomeLoading>(),
        isA<HomeReady>().having(
          (state) => state.syncOutcome,
          'sync outcome',
          SyncOutcome.usingCachedData,
        ),
      ],
    );
  });
}

final class _ClinicalReferenceRepository
    implements ClinicalReferenceRepository {
  const _ClinicalReferenceRepository(this.synchronizationResult);

  final Either<Failure, SyncOutcome> synchronizationResult;

  @override
  Future<Either<Failure, DiseaseDetails>> getDiseaseDetails({
    required int id,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, MedicineDetails>> getMedicineDetails({
    required int id,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, List<ClinicalSearchResult>>> search({
    required String query,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, SyncOutcome>> synchronize() async =>
      synchronizationResult;
}
