class ClinicalReferenceOverview {
  const ClinicalReferenceOverview({
    required this.diseases,
    required this.medicines,
  });

  final List<DiseaseSummary> diseases;
  final List<MedicineSummary> medicines;
}

class DiseaseSummary {
  const DiseaseSummary({
    required this.id,
    required this.name,
    required this.category,
  });

  final int id;
  final String name;
  final String category;
}

class MedicineSummary {
  const MedicineSummary({
    required this.id,
    required this.name,
    required this.genericName,
  });

  final int id;
  final String name;
  final String genericName;
}
