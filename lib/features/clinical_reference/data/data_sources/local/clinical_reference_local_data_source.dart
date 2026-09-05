import 'package:drift/drift.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/data/database/queries/clinical_details_query.dart';
import 'package:medbook/features/clinical_reference/data/database/queries/clinical_search_query.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';
import 'package:medbook/features/clinical_reference/domain/read_models/read_models.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/search/normalize_search_text.dart';

abstract interface class ClinicalReferenceLocalDataSource {
  Future<bool> hasCachedData();

  Future<ClinicalReferenceOverview> getOverview();

  Future<List<ClinicalSearchResult>> search({required String query});

  Future<DiseaseDetails?> getDiseaseDetails({required int id});

  Future<MedicineDetails?> getMedicineDetails({required int id});

  Future<void> replaceDataset({
    required ClinicalReferenceDataset dataset,
    required DateTime synchronizedAt,
  });
}

final class ClinicalReferenceLocalDataSourceImpl
    implements ClinicalReferenceLocalDataSource {
  ClinicalReferenceLocalDataSourceImpl(this._database)
    : _detailsQuery = ClinicalDetailsQuery(_database),
      _searchQuery = ClinicalSearchQuery(_database);

  static const _metadataKey = 'clinical_reference';

  final ClinicalDatabase _database;
  final ClinicalDetailsQuery _detailsQuery;
  final ClinicalSearchQuery _searchQuery;

  @override
  Future<bool> hasCachedData() async {
    final metadata = await (_database.select(
      _database.syncMetadata,
    )..limit(1)).getSingleOrNull();

    return metadata != null;
  }

  @override
  Future<ClinicalReferenceOverview> getOverview() async {
    final diseaseRows =
        await (_database.select(_database.diseases)
              ..orderBy([(row) => OrderingTerm.asc(row.id)])
              ..limit(2))
            .get();
    final medicineRows =
        await (_database.select(_database.medicines)
              ..orderBy([(row) => OrderingTerm.asc(row.id)])
              ..limit(3))
            .get();

    return ClinicalReferenceOverview(
      diseases: diseaseRows
          .map(
            (row) => DiseaseSummary(
              id: row.id,
              name: row.name,
              category: row.category,
            ),
          )
          .toList(growable: false),
      medicines: medicineRows
          .map(
            (row) => MedicineSummary(
              id: row.id,
              name: row.name,
              genericName: row.genericName,
            ),
          )
          .toList(growable: false),
    );
  }

  @override
  Future<List<ClinicalSearchResult>> search({required String query}) {
    return _searchQuery.search(query);
  }

  @override
  Future<DiseaseDetails?> getDiseaseDetails({required int id}) {
    return _detailsQuery.getDiseaseDetails(id);
  }

  @override
  Future<MedicineDetails?> getMedicineDetails({required int id}) {
    return _detailsQuery.getMedicineDetails(id);
  }

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
