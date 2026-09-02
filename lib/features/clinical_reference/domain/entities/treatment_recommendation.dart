/// A treatment recommendation linking one disease and one medicine.
class TreatmentRecommendation {
  const TreatmentRecommendation({
    required this.id,
    required this.diseaseId,
    required this.medicineId,
    required this.title,
    required this.type,
    required this.dose,
    required this.frequency,
    required this.duration,
    required this.notes,
  });

  final int id;
  final int diseaseId;
  final int medicineId;
  final String title;
  final String type;
  final String dose;
  final String frequency;
  final String duration;
  final String notes;
}
