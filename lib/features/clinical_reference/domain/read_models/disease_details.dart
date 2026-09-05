import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';

class DiseaseDetails {
  DiseaseDetails({
    required this.disease,
    required List<DiseaseTreatment> treatments,
  }) : treatments = List.unmodifiable(treatments);

  final Disease disease;
  final List<DiseaseTreatment> treatments;
}

class DiseaseTreatment {
  const DiseaseTreatment({
    required this.recommendation,
    required this.medicine,
  });

  final TreatmentRecommendation recommendation;
  final Medicine medicine;
}
