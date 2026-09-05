import 'package:drift/drift.dart';

@TableIndex(name: 'diseases_by_normalized_name', columns: {#normalizedName})
class Diseases extends Table {
  IntColumn get id => integer()();
  TextColumn get name => text()();
  TextColumn get normalizedName => text()();
  TextColumn get category => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}
