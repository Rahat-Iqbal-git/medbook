import 'package:drift/drift.dart';
import 'package:medbook/features/clinical_reference/data/database/tables/diseases.dart';

@TableIndex(
  name: 'disease_keywords_by_normalized_keyword',
  columns: {#normalizedKeyword},
)
@DataClassName('DiseaseKeywordRow')
class DiseaseKeywords extends Table {
  IntColumn get diseaseId => integer().references(
    Diseases,
    #id,
    onDelete: KeyAction.cascade,
  )();
  TextColumn get keyword => text()();
  TextColumn get normalizedKeyword => text()();

  @override
  Set<Column<Object>> get primaryKey => {diseaseId, normalizedKeyword};
}
