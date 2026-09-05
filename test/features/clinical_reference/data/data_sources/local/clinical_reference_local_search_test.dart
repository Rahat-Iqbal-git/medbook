import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medbook/features/clinical_reference/data/data_sources/data_sources.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/data/models/clinical_reference_dataset.dart';
import 'package:medbook/features/clinical_reference/domain/entities/entities.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';

void main() {
  group('local clinical search', () {
    late ClinicalDatabase database;
    late ClinicalReferenceLocalDataSource dataSource;

    setUp(() async {
      database = ClinicalDatabase(NativeDatabase.memory());
      dataSource = ClinicalReferenceLocalDataSourceImpl(database);
      await dataSource.replaceDataset(
        dataset: _searchDataset(),
        synchronizedAt: DateTime.utc(2026, 9, 5),
      );
    });

    tearDown(() => database.close());

    test('returns nothing for an empty query', () async {
      expect(await dataSource.search(query: '  \t '), isEmpty);
    });

    test('matches names partially without case sensitivity', () async {
      final results = await dataSource.search(query: 'SPIRATORY INFE');

      expect(results.map((result) => result.title), [
        'Aster Respiratory Infection',
      ]);
    });

    test('matches multiple words across disease keywords', () async {
      final results = await dataSource.search(query: 'rash skin');

      expect(results, hasLength(1));
      expect(results.single.type, ClinicalSearchResultType.disease);
      expect(results.single.title, 'Keyword Condition');
    });

    test('matches words across a disease name and its keywords', () async {
      final results = await dataSource.search(query: 'keyword rash');

      expect(results, hasLength(1));
      expect(results.single.type, ClinicalSearchResultType.disease);
      expect(results.single.title, 'Keyword Condition');
    });

    test('searches medicine generic names', () async {
      final results = await dataSource.search(query: 'formula beta');

      expect(results, hasLength(1));
      expect(results.single.type, ClinicalSearchResultType.medicine);
      expect(results.single.title, 'Remedy Beta');
    });

    test('ranks exact, prefix, keyword, then recommendation matches', () async {
      final results = await dataSource.search(query: 'medicine alpha');

      expect(results.map((result) => result.title), [
        'Medicine Alpha',
        'Medicine Alpha Extended',
        'Keyword Condition',
        'Protocol Condition',
        'Remedy Beta',
      ]);
    });

    test('turns recommendation matches into navigable results', () async {
      final results = await dataSource.search(query: '250 mg nightly');

      expect(results, hasLength(2));
      expect(results.map((result) => result.type), {
        ClinicalSearchResultType.disease,
        ClinicalSearchResultType.medicine,
      });
      expect(results.map((result) => result.id), {4, 30});
      expect(
        results.map((result) => result.subtitle),
        everyElement(contains('Medicine Alpha Protocol')),
      );
    });

    test('deduplicates results and orders equal matches by ID', () async {
      final results = await dataSource.search(query: 'shared exact');
      final diseases = results.where(
        (result) => result.type == ClinicalSearchResultType.disease,
      );

      expect(diseases.map((result) => result.id), [5, 6]);
    });

    test('treats SQL wildcard characters as normal text', () async {
      expect(await dataSource.search(query: '%'), isEmpty);
      expect(await dataSource.search(query: '_'), isEmpty);
    });
  });
}

ClinicalReferenceDataset _searchDataset() {
  return ClinicalReferenceDataset(
    version: 1,
    diseases: const [
      Disease(
        id: 1,
        name: 'Aster Respiratory Infection',
        category: 'Respiratory',
        keywords: ['cough'],
      ),
      Disease(
        id: 2,
        name: 'Prefix Condition',
        category: 'General',
        keywords: ['other'],
      ),
      Disease(
        id: 3,
        name: 'Keyword Condition',
        category: 'Skin',
        keywords: ['medicine alpha', 'skin', 'red rash'],
      ),
      Disease(
        id: 4,
        name: 'Protocol Condition',
        category: 'General',
        keywords: ['protocol'],
      ),
      Disease(
        id: 5,
        name: 'Shared Exact',
        category: 'Category B',
        keywords: ['shared'],
      ),
      Disease(
        id: 6,
        name: 'Shared Exact',
        category: 'Category A',
        keywords: ['shared'],
      ),
    ],
    medicines: const [
      Medicine(
        id: 10,
        name: 'Medicine Alpha',
        genericName: 'Formula A',
      ),
      Medicine(
        id: 20,
        name: 'Medicine Alpha Extended',
        genericName: 'Formula Extended',
      ),
      Medicine(
        id: 30,
        name: 'Remedy Beta',
        genericName: 'Formula Beta',
      ),
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
        diseaseId: 2,
        medicineId: 20,
        type: 'Alternative',
        dose: '100 mg',
        frequency: 'Daily',
        duration: '3 days',
      ),
      TreatmentRecommendation(
        id: 102,
        diseaseId: 3,
        medicineId: 30,
        type: 'Support',
        dose: '50 mg',
        frequency: 'Daily',
        duration: '2 days',
      ),
      TreatmentRecommendation(
        id: 103,
        diseaseId: 4,
        medicineId: 30,
        type: 'Medicine Alpha Protocol',
        dose: '250 mg',
        frequency: 'Nightly',
        duration: '4 days',
      ),
      TreatmentRecommendation(
        id: 104,
        diseaseId: 5,
        medicineId: 10,
        type: 'Shared Exact Plan',
        dose: '10 mg',
        frequency: 'Daily',
        duration: '1 day',
      ),
      TreatmentRecommendation(
        id: 105,
        diseaseId: 5,
        medicineId: 20,
        type: 'Shared Exact Backup',
        dose: '20 mg',
        frequency: 'Daily',
        duration: '1 day',
      ),
      TreatmentRecommendation(
        id: 106,
        diseaseId: 6,
        medicineId: 20,
        type: 'Shared Exact Plan',
        dose: '10 mg',
        frequency: 'Daily',
        duration: '1 day',
      ),
    ],
  );
}
