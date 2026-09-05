import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';

void main() {
  group(ClinicalDatabase, () {
    late ClinicalDatabase database;

    setUp(() {
      database = ClinicalDatabase(NativeDatabase.memory());
    });

    tearDown(() => database.close());

    test('opens an in-memory database', () async {
      final result = await database
          .customSelect('SELECT sqlite_version() AS version')
          .getSingle();

      expect(result.read<String>('version'), isNotEmpty);
    });

    test('enables foreign-key enforcement', () async {
      final result = await database
          .customSelect('PRAGMA foreign_keys')
          .getSingle();

      expect(result.read<int>('foreign_keys'), 1);
    });

    test('rejects recommendations whose relationships do not exist', () async {
      final insert = database
          .into(database.treatmentRecommendations)
          .insert(
            TreatmentRecommendationsCompanion.insert(
              id: const Value(100),
              diseaseId: 1,
              medicineId: 10,
              type: 'First Line',
              dose: '500 mg',
              frequency: 'Twice daily',
              duration: '5 days',
              normalizedSearchText: 'first line 500 mg twice daily 5 days',
            ),
          );

      await expectLater(insert, throwsA(isA<SqliteException>()));
    });

    test('cascades disease deletion to keywords and recommendations', () async {
      await database
          .into(database.diseases)
          .insert(
            DiseasesCompanion.insert(
              id: const Value(1),
              name: 'Sample Respiratory Infection',
              normalizedName: 'sample respiratory infection',
              category: 'Respiratory',
            ),
          );
      await database
          .into(database.medicines)
          .insert(
            MedicinesCompanion.insert(
              id: const Value(10),
              name: 'Medicine Alpha',
              normalizedName: 'medicine alpha',
              genericName: 'Sample Generic A',
              normalizedGenericName: 'sample generic a',
            ),
          );
      await database
          .into(database.diseaseKeywords)
          .insert(
            DiseaseKeywordsCompanion.insert(
              diseaseId: 1,
              keyword: 'respiratory',
              normalizedKeyword: 'respiratory',
            ),
          );
      await database
          .into(database.treatmentRecommendations)
          .insert(
            TreatmentRecommendationsCompanion.insert(
              id: const Value(100),
              diseaseId: 1,
              medicineId: 10,
              type: 'First Line',
              dose: '500 mg',
              frequency: 'Twice daily',
              duration: '5 days',
              normalizedSearchText: 'first line 500 mg twice daily 5 days',
            ),
          );

      await (database.delete(
        database.diseases,
      )..where((row) => row.id.equals(1))).go();

      expect(await database.select(database.diseaseKeywords).get(), isEmpty);
      expect(
        await database.select(database.treatmentRecommendations).get(),
        isEmpty,
      );
      expect(await database.select(database.medicines).get(), hasLength(1));
    });
  });
}
