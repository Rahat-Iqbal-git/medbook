import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/repositories/clinical_reference_repository.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';
import 'package:medbook/features/clinical_reference/presentation/disease_detail/cubit/disease_detail_cubit.dart';

void main() {
  blocTest<DiseaseDetailCubit, DiseaseDetailState>(
    'loads disease details from the repository',
    build: () => DiseaseDetailCubit(_ClinicalReferenceRepository()),
    act: (cubit) => cubit.load(1),
    expect: () => [isA<DiseaseDetailLoading>(), isA<DiseaseDetailLoaded>()],
  );
}

final class _ClinicalReferenceRepository
    implements ClinicalReferenceRepository {
  @override
  Future<Either<Failure, ClinicalReferenceOverview>> getOverview() =>
      throw UnimplementedError();

  @override
  Future<Either<Failure, DiseaseDetails>> getDiseaseDetails({
    required int id,
  }) async => Right(
    DiseaseDetails(
      disease: const Disease(
        id: 1,
        name: 'Aster Condition',
        category: 'Respiratory',
        keywords: ['aster'],
      ),
      treatments: const [],
    ),
  );

  @override
  Future<Either<Failure, MedicineDetails>> getMedicineDetails({
    required int id,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, List<ClinicalSearchResult>>> search({
    required String query,
  }) => throw UnimplementedError();

  @override
  Future<Either<Failure, SyncOutcome>> synchronize() =>
      throw UnimplementedError();
}
