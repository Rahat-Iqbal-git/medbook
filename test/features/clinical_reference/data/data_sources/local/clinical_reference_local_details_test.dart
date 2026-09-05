import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';

void main() {
  group('local clinical details', () {
    late ClinicalDatabase database;
    late ClinicalReferenceLocalDataSource dataSource;

    setUp(() async {
      database = ClinicalDatabase(NativeDatabase.memory());
      dataSource = ClinicalReferenceLocalDataSourceImpl(database);
      await dataSource.replaceDataset(
        dataset: _detailsDataset,
        synchronizedAt: DateTime.utc(2026, 9, 5),
      );
    });

    tearDown(() => database.close());

    test('loads a disease with keywords, medicines, and treatments', () async {
      final details = await dataSource.getDiseaseDetails(id: 1);

      expect(details, isNotNull);
      expect(details!.disease.id, 1);
      expect(details.disease.name, 'Aster Condition');
      expect(details.disease.keywords, ['cough', 'respiratory']);
      expect(
        details.treatments.map((item) => item.medicine.name),
        ['Medicine Alpha', 'Medicine Beta'],
      );
      expect(details.treatments.first.recommendation.type, 'First Line');
      expect(details.treatments.first.recommendation.dose, '500 mg');
      expect(details.treatments.first.recommendation.frequency, 'Twice daily');
      expect(details.treatments.first.recommendation.duration, '5 days');
    });

    test('loads a medicine with diseases, keywords, and treatments', () async {
      final details = await dataSource.getMedicineDetails(id: 10);

      expect(details, isNotNull);
      expect(details!.medicine.id, 10);
      expect(details.medicine.genericName, 'Formula A');
      expect(
        details.treatments.map((item) => item.disease.name),
        ['Aster Condition', 'Zinnia Condition'],
      );
      expect(details.treatments.first.disease.keywords, [
        'cough',
        'respiratory',
      ]);
      expect(details.treatments.last.disease.keywords, ['skin']);
      expect(details.treatments.last.recommendation.type, 'Supportive');
    });

    test('returns no details when the item does not exist', () async {
      expect(await dataSource.getDiseaseDetails(id: 999), isNull);
      expect(await dataSource.getMedicineDetails(id: 999), isNull);
    });
  });
}

final _detailsDataset = ClinicalReferenceDataset(
  version: 1,
  diseases: const [
    Disease(
      id: 1,
      name: 'Aster Condition',
      category: 'Respiratory',
      keywords: ['respiratory', 'cough'],
    ),
    Disease(
      id: 2,
      name: 'Zinnia Condition',
      category: 'Skin',
      keywords: ['skin'],
    ),
  ],
  medicines: const [
    Medicine(id: 10, name: 'Medicine Alpha', genericName: 'Formula A'),
    Medicine(id: 20, name: 'Medicine Beta', genericName: 'Formula B'),
  ],
  recommendations: const [
    TreatmentRecommendation(
      id: 100,
      diseaseId: 1,
      medicineId: 10,
      type: 'First Line',
      dose: '500 mg',
      frequency: 'Twice daily',
      duration: '5 days',
    ),
    TreatmentRecommendation(
      id: 101,
      diseaseId: 1,
      medicineId: 20,
      type: 'Alternative',
      dose: '250 mg',
      frequency: 'Daily',
      duration: '3 days',
    ),
    TreatmentRecommendation(
      id: 102,
      diseaseId: 2,
      medicineId: 10,
      type: 'Supportive',
      dose: '100 mg',
      frequency: 'Nightly',
      duration: '2 days',
    ),
  ],
);
