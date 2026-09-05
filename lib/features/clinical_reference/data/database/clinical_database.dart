import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:medbook/features/clinical_reference/data/database/tables/tables.dart';

part 'clinical_database.g.dart';

@DriftDatabase(
  tables: [
    Diseases,
    DiseaseKeywords,
    Medicines,
    TreatmentRecommendations,
    SyncMetadata,
  ],
)
final class ClinicalDatabase extends _$ClinicalDatabase {
  ClinicalDatabase(super.e);

  ClinicalDatabase.defaults() : super(driftDatabase(name: 'medbook'));

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    beforeOpen: (_) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
}
