import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';

class MedicineDetails {
  MedicineDetails({
    required this.medicine,
    required List<MedicineTreatment> treatments,
  }) : treatments = List.unmodifiable(treatments);

  final Medicine medicine;
  final List<MedicineTreatment> treatments;
}

class MedicineTreatment {
  const MedicineTreatment({
    required this.recommendation,
    required this.disease,
  });

  final TreatmentRecommendation recommendation;
  final Disease disease;
}
