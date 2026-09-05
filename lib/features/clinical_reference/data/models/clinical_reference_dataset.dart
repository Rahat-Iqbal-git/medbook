import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';

final class ClinicalReferenceDataset {
  ClinicalReferenceDataset({
    required this.version,
    required List<Disease> diseases,
    required List<Medicine> medicines,
    required List<TreatmentRecommendation> recommendations,
  }) : diseases = List.unmodifiable(diseases),
       medicines = List.unmodifiable(medicines),
       recommendations = List.unmodifiable(recommendations);

  final int version;
  final List<Disease> diseases;
  final List<Medicine> medicines;
  final List<TreatmentRecommendation> recommendations;
}
