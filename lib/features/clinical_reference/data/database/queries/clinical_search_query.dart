import 'package:drift/drift.dart';
import 'package:medbook/features/clinical_reference/data/database/clinical_database.dart';
import 'package:medbook/features/clinical_reference/domain/search/clinical_search_result.dart';
import 'package:medbook/features/clinical_reference/domain/search/normalize_search_text.dart';

final class ClinicalSearchQuery {
  const ClinicalSearchQuery(this._database);

  final ClinicalDatabase _database;

  Future<List<ClinicalSearchResult>> search(String query) async {
    final normalizedQuery = normalizeSearchText(query);
    if (normalizedQuery.isEmpty) {
      return const [];
    }

    final tokens = normalizedQuery.split(' ');
    final results = _RankedResults()
      ..addAll(await _findDiseasesByName(normalizedQuery, tokens))
      ..addAll(await _findMedicinesByName(normalizedQuery, tokens))
      ..addAll(await _findDiseasesByNameOrKeyword(tokens))
      ..addAll(await _findByRecommendation(tokens));

    return results.sorted();
  }

  Future<List<_RankedResult>> _findDiseasesByName(
    String normalizedQuery,
    List<String> tokens,
  ) async {
    final statement = _database.select(_database.diseases);
    for (final token in tokens) {
      statement.where(
        (row) => row.normalizedName.like(
          _containsPattern(token),
          escapeChar: r'\',
        ),
      );
    }

    final rows = await statement.get();
    return rows
        .map(
          (row) => _RankedResult(
            result: ClinicalSearchResult(
              id: row.id,
              type: ClinicalSearchResultType.disease,
              title: row.name,
              subtitle: row.category,
            ),
            score: _diseaseNameScore(row.normalizedName, normalizedQuery),
          ),
        )
        .toList(growable: false);
  }

  Future<List<_RankedResult>> _findMedicinesByName(
    String normalizedQuery,
    List<String> tokens,
  ) async {
    final statement = _database.select(_database.medicines);
    for (final token in tokens) {
      final pattern = _containsPattern(token);
      statement.where(
        (row) =>
            row.normalizedName.like(pattern, escapeChar: r'\') |
            row.normalizedGenericName.like(pattern, escapeChar: r'\'),
      );
    }

    final rows = await statement.get();
    return rows
        .map(
          (row) => _RankedResult(
            result: ClinicalSearchResult(
              id: row.id,
              type: ClinicalSearchResultType.medicine,
              title: row.name,
              subtitle: row.genericName,
            ),
            score: _medicineNameScore(
              row.normalizedName,
              row.normalizedGenericName,
              normalizedQuery,
              tokens,
            ),
          ),
        )
        .toList(growable: false);
  }

  Future<List<_RankedResult>> _findDiseasesByNameOrKeyword(
    List<String> tokens,
  ) async {
    Set<int>? matchingDiseaseIds;

    for (final token in tokens) {
      final tokenMatches = await _diseaseIdsMatching(token);

      if (matchingDiseaseIds == null) {
        matchingDiseaseIds = tokenMatches;
      } else {
        matchingDiseaseIds.retainAll(tokenMatches);
      }

      if (matchingDiseaseIds.isEmpty) {
        return const [];
      }
    }

    final statement = _database.select(_database.diseases)
      ..where((row) => row.id.isIn(matchingDiseaseIds!));
    final rows = await statement.get();

    return rows
        .map(
          (row) => _RankedResult(
            result: ClinicalSearchResult(
              id: row.id,
              type: ClinicalSearchResultType.disease,
              title: row.name,
              subtitle: row.category,
            ),
            score: _SearchScore.keyword,
          ),
        )
        .toList(growable: false);
  }

  Future<Set<int>> _diseaseIdsMatching(String token) async {
    final pattern = _containsPattern(token);
    final keywordDiseaseId = _database.diseaseKeywords.diseaseId;
    final keywordStatement = _database.selectOnly(_database.diseaseKeywords)
      ..addColumns([keywordDiseaseId])
      ..where(
        _database.diseaseKeywords.normalizedKeyword.like(
          pattern,
          escapeChar: r'\',
        ),
      );
    final nameStatement = _database.selectOnly(_database.diseases)
      ..addColumns([_database.diseases.id])
      ..where(
        _database.diseases.normalizedName.like(pattern, escapeChar: r'\'),
      );

    final keywordRows = await keywordStatement.get();
    final nameRows = await nameStatement.get();

    return {
      ...keywordRows.map((row) => row.read(keywordDiseaseId)!),
      ...nameRows.map((row) => row.read(_database.diseases.id)!),
    };
  }

  Future<List<_RankedResult>> _findByRecommendation(
    List<String> tokens,
  ) async {
    final recommendations = _database.treatmentRecommendations;
    final diseases = _database.diseases;
    final medicines = _database.medicines;
    final statement = _database.select(recommendations).join([
      innerJoin(diseases, diseases.id.equalsExp(recommendations.diseaseId)),
      innerJoin(medicines, medicines.id.equalsExp(recommendations.medicineId)),
    ]);

    for (final token in tokens) {
      statement.where(
        recommendations.normalizedSearchText.like(
          _containsPattern(token),
          escapeChar: r'\',
        ),
      );
    }

    final rows = await statement.get();
    final results = <_RankedResult>[];
    for (final row in rows) {
      final recommendation = row.readTable(recommendations);
      final disease = row.readTable(diseases);
      final medicine = row.readTable(medicines);

      results
        ..add(
          _RankedResult(
            result: ClinicalSearchResult(
              id: disease.id,
              type: ClinicalSearchResultType.disease,
              title: disease.name,
              subtitle: '${recommendation.type} · ${medicine.name}',
            ),
            score: _SearchScore.recommendation,
          ),
        )
        ..add(
          _RankedResult(
            result: ClinicalSearchResult(
              id: medicine.id,
              type: ClinicalSearchResultType.medicine,
              title: medicine.name,
              subtitle: '${recommendation.type} · ${disease.name}',
            ),
            score: _SearchScore.recommendation,
          ),
        );
    }

    return results;
  }
}

abstract final class _SearchScore {
  static const exactName = 1000;
  static const namePrefix = 800;
  static const exactGenericName = 750;
  static const partialName = 700;
  static const genericNamePrefix = 650;
  static const genericName = 600;
  static const keyword = 500;
  static const recommendation = 300;
}

final class _RankedResult {
  const _RankedResult({required this.result, required this.score});

  final ClinicalSearchResult result;
  final int score;
}

final class _RankedResults {
  final _results = <(ClinicalSearchResultType, int), _RankedResult>{};

  void addAll(Iterable<_RankedResult> candidates) {
    for (final candidate in candidates) {
      final result = candidate.result;
      final key = (result.type, result.id);
      final existing = _results[key];

      if (existing == null || _isPreferred(candidate, existing)) {
        _results[key] = candidate;
      }
    }
  }

  List<ClinicalSearchResult> sorted() {
    final rankedResults = _results.values.toList()..sort(_compare);
    return rankedResults.map((item) => item.result).toList(growable: false);
  }

  bool _isPreferred(_RankedResult candidate, _RankedResult existing) {
    if (candidate.score != existing.score) {
      return candidate.score > existing.score;
    }

    return candidate.result.subtitle.compareTo(existing.result.subtitle) < 0;
  }

  int _compare(_RankedResult left, _RankedResult right) {
    final scoreComparison = right.score.compareTo(left.score);
    if (scoreComparison != 0) {
      return scoreComparison;
    }

    final titleComparison = normalizeSearchText(
      left.result.title,
    ).compareTo(normalizeSearchText(right.result.title));
    if (titleComparison != 0) {
      return titleComparison;
    }

    final typeComparison = left.result.type.index.compareTo(
      right.result.type.index,
    );
    if (typeComparison != 0) {
      return typeComparison;
    }

    return left.result.id.compareTo(right.result.id);
  }
}

int _diseaseNameScore(String name, String query) {
  if (name == query) {
    return _SearchScore.exactName;
  }
  if (name.startsWith(query)) {
    return _SearchScore.namePrefix;
  }
  return _SearchScore.partialName;
}

int _medicineNameScore(
  String name,
  String genericName,
  String query,
  List<String> tokens,
) {
  if (name == query) {
    return _SearchScore.exactName;
  }
  if (name.startsWith(query)) {
    return _SearchScore.namePrefix;
  }
  if (genericName == query) {
    return _SearchScore.exactGenericName;
  }
  if (_containsEveryToken(name, tokens)) {
    return _SearchScore.partialName;
  }
  if (genericName.startsWith(query)) {
    return _SearchScore.genericNamePrefix;
  }
  return _SearchScore.genericName;
}

bool _containsEveryToken(String value, List<String> tokens) {
  return tokens.every(value.contains);
}

String _containsPattern(String value) {
  final escaped = value
      .replaceAll(r'\', r'\\')
      .replaceAll('%', r'\%')
      .replaceAll('_', r'\_');
  return '%$escaped%';
}
