import 'package:drift/drift.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';

final class ClinicalDetailsQuery {
  const ClinicalDetailsQuery(this._database);

  final ClinicalDatabase _database;

  Future<DiseaseDetails?> getDiseaseDetails(int id) {
    return _database.transaction(() => _getDiseaseDetails(id));
  }

  Future<DiseaseDetails?> _getDiseaseDetails(int id) async {
    final diseaseRow = await (_database.select(
      _database.diseases,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (diseaseRow == null) {
      return null;
    }

    final keywords = await _loadKeywordsForDisease(id);
    final recommendations = _database.treatmentRecommendations;
    final medicines = _database.medicines;
    final statement = _database.select(recommendations).join([
      innerJoin(medicines, medicines.id.equalsExp(recommendations.medicineId)),
    ])..where(recommendations.diseaseId.equals(id));
    final rows = await statement.get();

    final treatments = rows.map((row) {
      final recommendation = row.readTable(recommendations);
      final medicine = row.readTable(medicines);
      return DiseaseTreatment(
        recommendation: _recommendationFromRow(recommendation),
        medicine: _medicineFromRow(medicine),
      );
    }).toList()..sort(_compareDiseaseTreatments);

    return DiseaseDetails(
      disease: _diseaseFromRow(diseaseRow, keywords),
      treatments: treatments,
    );
  }

  Future<MedicineDetails?> getMedicineDetails(int id) {
    return _database.transaction(() => _getMedicineDetails(id));
  }

  Future<MedicineDetails?> _getMedicineDetails(int id) async {
    final medicineRow = await (_database.select(
      _database.medicines,
    )..where((row) => row.id.equals(id))).getSingleOrNull();
    if (medicineRow == null) {
      return null;
    }

    final recommendations = _database.treatmentRecommendations;
    final diseases = _database.diseases;
    final statement = _database.select(recommendations).join([
      innerJoin(diseases, diseases.id.equalsExp(recommendations.diseaseId)),
    ])..where(recommendations.medicineId.equals(id));
    final rows = await statement.get();
    final diseaseIds = rows.map((row) => row.readTable(diseases).id).toSet();
    final keywordsByDisease = await _loadKeywordsForDiseases(diseaseIds);

    final treatments = rows.map((row) {
      final recommendation = row.readTable(recommendations);
      final disease = row.readTable(diseases);
      return MedicineTreatment(
        recommendation: _recommendationFromRow(recommendation),
        disease: _diseaseFromRow(
          disease,
          keywordsByDisease[disease.id] ?? const [],
        ),
      );
    }).toList()..sort(_compareMedicineTreatments);

    return MedicineDetails(
      medicine: _medicineFromRow(medicineRow),
      treatments: treatments,
    );
  }

  Future<List<String>> _loadKeywordsForDisease(int diseaseId) async {
    final rows =
        await (_database.select(_database.diseaseKeywords)
              ..where((row) => row.diseaseId.equals(diseaseId))
              ..orderBy([(row) => OrderingTerm.asc(row.normalizedKeyword)]))
            .get();
    return rows.map((row) => row.keyword).toList(growable: false);
  }

  Future<Map<int, List<String>>> _loadKeywordsForDiseases(
    Set<int> diseaseIds,
  ) async {
    if (diseaseIds.isEmpty) {
      return const {};
    }

    final rows =
        await (_database.select(_database.diseaseKeywords)
              ..where((row) => row.diseaseId.isIn(diseaseIds))
              ..orderBy([
                (row) => OrderingTerm.asc(row.diseaseId),
                (row) => OrderingTerm.asc(row.normalizedKeyword),
              ]))
            .get();
    final keywordsByDisease = <int, List<String>>{};
    for (final row in rows) {
      keywordsByDisease.putIfAbsent(row.diseaseId, () => []).add(row.keyword);
    }
    return keywordsByDisease;
  }
}

Disease _diseaseFromRow(DiseaseRow row, List<String> keywords) {
  return Disease(
    id: row.id,
    name: row.name,
    category: row.category,
    keywords: List.unmodifiable(keywords),
  );
}

Medicine _medicineFromRow(MedicineRow row) {
  return Medicine(
    id: row.id,
    name: row.name,
    genericName: row.genericName,
  );
}

TreatmentRecommendation _recommendationFromRow(
  TreatmentRecommendationRow row,
) {
  return TreatmentRecommendation(
    id: row.id,
    diseaseId: row.diseaseId,
    medicineId: row.medicineId,
    type: row.type,
    dose: row.dose,
    frequency: row.frequency,
    duration: row.duration,
  );
}

int _compareDiseaseTreatments(DiseaseTreatment left, DiseaseTreatment right) {
  final nameComparison = left.medicine.name.toLowerCase().compareTo(
    right.medicine.name.toLowerCase(),
  );
  if (nameComparison != 0) {
    return nameComparison;
  }
  return left.recommendation.id.compareTo(right.recommendation.id);
}

int _compareMedicineTreatments(
  MedicineTreatment left,
  MedicineTreatment right,
) {
  final nameComparison = left.disease.name.toLowerCase().compareTo(
    right.disease.name.toLowerCase(),
  );
  if (nameComparison != 0) {
    return nameComparison;
  }
  return left.recommendation.id.compareTo(right.recommendation.id);
}
