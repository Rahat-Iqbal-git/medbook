import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';

abstract interface class ClinicalReferenceRepository {
  Future<Either<Failure, SyncOutcome>> synchronize();

  Future<Either<Failure, ClinicalReferenceOverview>> getOverview();

  Future<Either<Failure, List<ClinicalSearchResult>>> search({
    required String query,
  });

  Future<Either<Failure, DiseaseDetails>> getDiseaseDetails({
    required int id,
  });

  Future<Either<Failure, MedicineDetails>> getMedicineDetails({
    required int id,
  });
}
