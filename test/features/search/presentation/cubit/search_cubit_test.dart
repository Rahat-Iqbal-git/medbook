import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';
import 'package:medbook/features/search/presentation/cubit/search_cubit.dart';

void main() {
  group('SearchCubit', () {
    blocTest<SearchCubit, SearchState>(
      'debounces the query and exposes ranked results',
      build: () => SearchCubit(
        const _ClinicalReferenceRepository([
          ClinicalSearchResult(
            id: 1,
            type: ClinicalSearchResultType.disease,
            title: 'Aster Condition',
            subtitle: 'Respiratory',
          ),
        ]),
        debounceDuration: Duration.zero,
      ),
      act: (cubit) => cubit.queryChanged('aster'),
      expect: () => [isA<SearchLoading>(), isA<SearchResults>()],
    );

    blocTest<SearchCubit, SearchState>(
      'shows an empty state when the ranked query has no matches',
      build: () => SearchCubit(
        const _ClinicalReferenceRepository([]),
        debounceDuration: Duration.zero,
      ),
      act: (cubit) => cubit.queryChanged('missing'),
      expect: () => [isA<SearchLoading>(), isA<SearchEmpty>()],
    );
  });
}

final class _ClinicalReferenceRepository
    implements ClinicalReferenceRepository {
  const _ClinicalReferenceRepository(this.searchResults);

  final List<ClinicalSearchResult> searchResults;

  @override
  Future<Either<Failure, ClinicalReferenceOverview>> getOverview() =>
      throw UnimplementedError();

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
  }) async => Right(searchResults);

  @override
  Future<Either<Failure, SyncOutcome>> synchronize() =>
      throw UnimplementedError();
}
