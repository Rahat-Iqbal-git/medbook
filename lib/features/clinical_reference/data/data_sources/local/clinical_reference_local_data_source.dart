import 'package:drift/drift.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';
import 'package:medbook/features/clinical_reference/domain/search/normalize_search_text.dart';

// Keeps local persistence replaceable at the repository boundary.
// ignore: one_member_abstracts
abstract interface class ClinicalReferenceLocalDataSource {
  Future<void> replaceDataset({
    required ClinicalReferenceDataset dataset,
    required DateTime synchronizedAt,
  });
}

final class ClinicalReferenceLocalDataSourceImpl
    implements ClinicalReferenceLocalDataSource {
  const ClinicalReferenceLocalDataSourceImpl(this._database);

  static const _metadataKey = 'clinical_reference';

  final ClinicalDatabase _database;

  @override
  Future<void> replaceDataset({
    required ClinicalReferenceDataset dataset,
    required DateTime synchronizedAt,
  }) async {
    final diseaseRows = dataset.diseases.map(_diseaseRow).toList();
    final keywordRows = dataset.diseases.expand(_keywordRows).toList();
    final medicineRows = dataset.medicines.map(_medicineRow).toList();
    final recommendationRows = dataset.recommendations
        .map(_recommendationRow)
        .toList();

    await _database.transaction(() async {
      await _database.delete(_database.treatmentRecommendations).go();
      await _database.delete(_database.diseaseKeywords).go();
      await _database.delete(_database.diseases).go();
      await _database.delete(_database.medicines).go();

      await _database.batch((batch) {
        batch
          ..insertAll(_database.diseases, diseaseRows)
          ..insertAll(_database.diseaseKeywords, keywordRows)
          ..insertAll(_database.medicines, medicineRows)
          ..insertAll(
            _database.treatmentRecommendations,
            recommendationRows,
          );
      });

      await _database
          .into(_database.syncMetadata)
          .insertOnConflictUpdate(
            SyncMetadataCompanion.insert(
              key: _metadataKey,
              datasetVersion: dataset.version,
              lastSuccessfulSync: synchronizedAt.toUtc(),
            ),
          );
    });
  }
}

DiseasesCompanion _diseaseRow(Disease disease) {
  return DiseasesCompanion.insert(
    id: Value(disease.id),
    name: disease.name,
    normalizedName: normalizeSearchText(disease.name),
    category: disease.category,
  );
}

Iterable<DiseaseKeywordsCompanion> _keywordRows(Disease disease) {
  return disease.keywords.map(
    (keyword) => DiseaseKeywordsCompanion.insert(
      diseaseId: disease.id,
      keyword: keyword,
      normalizedKeyword: normalizeSearchText(keyword),
    ),
  );
}

MedicinesCompanion _medicineRow(Medicine medicine) {
  return MedicinesCompanion.insert(
    id: Value(medicine.id),
    name: medicine.name,
    normalizedName: normalizeSearchText(medicine.name),
    genericName: medicine.genericName,
    normalizedGenericName: normalizeSearchText(medicine.genericName),
  );
}

TreatmentRecommendationsCompanion _recommendationRow(
  TreatmentRecommendation recommendation,
) {
  final searchableText = [
    recommendation.type,
    recommendation.dose,
    recommendation.frequency,
    recommendation.duration,
  ].join(' ');

  return TreatmentRecommendationsCompanion.insert(
    id: Value(recommendation.id),
    diseaseId: recommendation.diseaseId,
    medicineId: recommendation.medicineId,
    type: recommendation.type,
    dose: recommendation.dose,
    frequency: recommendation.frequency,
    duration: recommendation.duration,
    normalizedSearchText: normalizeSearchText(searchableText),
  );
}
