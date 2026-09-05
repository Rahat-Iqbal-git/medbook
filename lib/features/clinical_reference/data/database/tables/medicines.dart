import 'package:drift/drift.dart';

@TableIndex(name: 'medicines_by_normalized_name', columns: {#normalizedName})
@TableIndex(
  name: 'medicines_by_normalized_generic_name',
  columns: {#normalizedGenericName},
)
class Medicines extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get normalizedName => text()();
  TextColumn get genericName => text()();
  TextColumn get normalizedGenericName => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
