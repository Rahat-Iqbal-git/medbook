import 'package:drift/drift.dart';

class SyncMetadata extends Table {
  TextColumn get key => text()();
  IntColumn get datasetVersion => integer()();
  DateTimeColumn get lastSuccessfulSync => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}
