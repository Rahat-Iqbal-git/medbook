import 'package:drift/drift.dart';
import 'package:medbook/features/clinical_reference/data/database/tables/diseases.dart';
import 'package:medbook/features/clinical_reference/data/database/tables/medicines.dart';

@TableIndex(
  name: 'recommendations_by_disease',
  columns: {#diseaseId},
)
@TableIndex(
  name: 'recommendations_by_medicine',
  columns: {#medicineId},
)
class TreatmentRecommendations extends Table {
  IntColumn get id => integer()();
  IntColumn get diseaseId => integer().references(
    Diseases,
    #id,
    onDelete: KeyAction.cascade,
  )();
  IntColumn get medicineId => integer().references(
    Medicines,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get type => text()();
  TextColumn get dose => text()();
  TextColumn get frequency => text()();
  TextColumn get duration => text()();
  TextColumn get normalizedSearchText => text()();

  @override
  String get tableName => 'recommendations';

  @override
  Set<Column<Object>> get primaryKey => {id};
}
