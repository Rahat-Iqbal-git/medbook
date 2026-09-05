import 'package:fpdart/fpdart.dart';
import 'package:medbook/core/failures/failure.dart';
import 'package:medbook/features/clinical_reference/domain/entities/disease.dart';
import 'package:medbook/features/clinical_reference/domain/entities/medicine.dart';
import 'package:medbook/features/clinical_reference/domain/entities/treatment_recommendation.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/sync/sync_outcome.dart';

abstract interface class ClinicalReferenceRepository {
  Future<Either<Failure, SyncOutcome>> synchronize();

  Future<Either<Failure, List<ClinicalSearchResult>>> search({
    required String query,
  });

  Future<Either<Failure, Disease>> getDiseaseById({required int id});

  Future<Either<Failure, Medicine>> getMedicineById({required int id});

  Future<Either<Failure, List<TreatmentRecommendation>>>
  getRecommendationsByDiseaseId({required int diseaseId});

  Future<Either<Failure, List<TreatmentRecommendation>>>
  getRecommendationsByMedicineId({required int medicineId});
}
