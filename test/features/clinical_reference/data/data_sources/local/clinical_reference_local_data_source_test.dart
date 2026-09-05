import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';

void main() {
  group('ClinicalReferenceLocalDataSource', () {
    late ClinicalDatabase database;
    late ClinicalReferenceLocalDataSource dataSource;

    setUp(() {
      database = ClinicalDatabase(NativeDatabase.memory());
      dataSource = ClinicalReferenceLocalDataSourceImpl(database);
    });

    tearDown(() => database.close());

    test('reports whether downloaded data is available', () async {
      expect(await dataSource.hasCachedData(), isFalse);

      await dataSource.replaceDataset(
        dataset: _dataset(),
        synchronizedAt: DateTime.utc(2026, 9, 5, 12),
      );

      expect(await dataSource.hasCachedData(), isTrue);
    });

    test('replaces the dataset and stores searchable text', () async {
      await dataSource.replaceDataset(
        dataset: _dataset(),
        synchronizedAt: DateTime.utc(2026, 9, 4, 12),
      );

      final synchronizedAt = DateTime.utc(2026, 9, 5, 12);
      await dataSource.replaceDataset(
        dataset: _dataset(
          version: 2,
          diseaseId: 2,
          medicineId: 20,
          recommendationId: 200,
          diseaseName: '  Aster   Skin VEIL ',
          medicineName: ' Medicine BETA ',
          genericName: ' Formula B ',
          keywords: const [' Rash '],
          recommendationType: ' Alternative ',
        ),
        synchronizedAt: synchronizedAt,
      );

      final diseases = await database.select(database.diseases).get();
      final medicines = await database.select(database.medicines).get();
      final keywords = await database.select(database.diseaseKeywords).get();
      final recommendations = await database
          .select(database.treatmentRecommendations)
          .get();
      final metadata = await database.select(database.syncMetadata).getSingle();

      expect(diseases.single.id, 2);
      expect(diseases.single.normalizedName, 'aster skin veil');
      expect(medicines.single.id, 20);
      expect(medicines.single.normalizedName, 'medicine beta');
      expect(medicines.single.normalizedGenericName, 'formula b');
      expect(keywords.single.normalizedKeyword, 'rash');
      expect(recommendations.single.id, 200);
      expect(
        recommendations.single.normalizedSearchText,
        'alternative 500 mg twice daily 5 days',
      );
      expect(metadata.datasetVersion, 2);
      expect(metadata.lastSuccessfulSync.toUtc(), synchronizedAt);
    });

    test('preserves the previous dataset when replacement fails', () async {
      final firstSync = DateTime.utc(2026, 9, 4, 12);
      await dataSource.replaceDataset(
        dataset: _dataset(),
        synchronizedAt: firstSync,
      );

      final invalidReplacement = _dataset(
        version: 2,
        diseaseId: 2,
        medicineId: 20,
        recommendationId: 200,
        recommendationDiseaseId: 999,
      );

      await expectLater(
        dataSource.replaceDataset(
          dataset: invalidReplacement,
          synchronizedAt: DateTime.utc(2026, 9, 5, 12),
        ),
        throwsA(isA<SqliteException>()),
      );

      final diseases = await database.select(database.diseases).get();
      final medicines = await database.select(database.medicines).get();
      final recommendations = await database
          .select(database.treatmentRecommendations)
          .get();
      final metadata = await database.select(database.syncMetadata).getSingle();

      expect(diseases.single.id, 1);
      expect(medicines.single.id, 10);
      expect(recommendations.single.id, 100);
      expect(metadata.datasetVersion, 1);
      expect(metadata.lastSuccessfulSync.toUtc(), firstSync);
    });
  });
}

ClinicalReferenceDataset _dataset({
  int version = 1,
  int diseaseId = 1,
  int medicineId = 10,
  int recommendationId = 100,
  int? recommendationDiseaseId,
  String diseaseName = 'Aster Respiratory Veil',
  String medicineName = 'Medicine Alpha',
  String genericName = 'Formula A',
  List<String> keywords = const ['respiratory', 'cough'],
  String recommendationType = 'First Line',
}) {
  return ClinicalReferenceDataset(
    version: version,
    diseases: [
      Disease(
        id: diseaseId,
        name: diseaseName,
        category: 'Sample Category',
        keywords: keywords,
      ),
    ],
    medicines: [
      Medicine(
        id: medicineId,
        name: medicineName,
        genericName: genericName,
      ),
    ],
    recommendations: [
      TreatmentRecommendation(
        id: recommendationId,
        diseaseId: recommendationDiseaseId ?? diseaseId,
        medicineId: medicineId,
        type: recommendationType,
        dose: '500 mg',
        frequency: 'Twice daily',
        duration: '5 days',
      ),
    ],
  );
}
