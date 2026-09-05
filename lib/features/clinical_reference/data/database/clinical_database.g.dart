// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clinical_database.dart';

// ignore_for_file: type=lint
class $DiseasesTable extends Diseases
    with TableInfo<$DiseasesTable, DiseaseRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiseasesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, normalizedName, category];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'diseases';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiseaseRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DiseaseRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiseaseRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
    );
  }

  @override
  $DiseasesTable createAlias(String alias) {
    return $DiseasesTable(attachedDatabase, alias);
  }
}

class DiseaseRow extends DataClass implements Insertable<DiseaseRow> {
  final int id;
  final String name;
  final String normalizedName;
  final String category;
  const DiseaseRow({
    required this.id,
    required this.name,
    required this.normalizedName,
    required this.category,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['normalized_name'] = Variable<String>(normalizedName);
    map['category'] = Variable<String>(category);
    return map;
  }

  DiseasesCompanion toCompanion(bool nullToAbsent) {
    return DiseasesCompanion(
      id: Value(id),
      name: Value(name),
      normalizedName: Value(normalizedName),
      category: Value(category),
    );
  }

  factory DiseaseRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiseaseRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      category: serializer.fromJson<String>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'category': serializer.toJson<String>(category),
    };
  }

  DiseaseRow copyWith({
    int? id,
    String? name,
    String? normalizedName,
    String? category,
  }) => DiseaseRow(
    id: id ?? this.id,
    name: name ?? this.name,
    normalizedName: normalizedName ?? this.normalizedName,
    category: category ?? this.category,
  );
  DiseaseRow copyWithCompanion(DiseasesCompanion data) {
    return DiseaseRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      category: data.category.present ? data.category.value : this.category,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiseaseRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, normalizedName, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiseaseRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.category == this.category);
}

class DiseasesCompanion extends UpdateCompanion<DiseaseRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> normalizedName;
  final Value<String> category;
  const DiseasesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.category = const Value.absent(),
  });
  DiseasesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String normalizedName,
    required String category,
  }) : name = Value(name),
       normalizedName = Value(normalizedName),
       category = Value(category);
  static Insertable<DiseaseRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (category != null) 'category': category,
    });
  }

  DiseasesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? normalizedName,
    Value<String>? category,
  }) {
    return DiseasesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiseasesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class $DiseaseKeywordsTable extends DiseaseKeywords
    with TableInfo<$DiseaseKeywordsTable, DiseaseKeywordRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DiseaseKeywordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _diseaseIdMeta = const VerificationMeta(
    'diseaseId',
  );
  @override
  late final GeneratedColumn<int> diseaseId = GeneratedColumn<int>(
    'disease_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES diseases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _keywordMeta = const VerificationMeta(
    'keyword',
  );
  @override
  late final GeneratedColumn<String> keyword = GeneratedColumn<String>(
    'keyword',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedKeywordMeta = const VerificationMeta(
    'normalizedKeyword',
  );
  @override
  late final GeneratedColumn<String> normalizedKeyword =
      GeneratedColumn<String>(
        'normalized_keyword',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [diseaseId, keyword, normalizedKeyword];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'disease_keywords';
  @override
  VerificationContext validateIntegrity(
    Insertable<DiseaseKeywordRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('disease_id')) {
      context.handle(
        _diseaseIdMeta,
        diseaseId.isAcceptableOrUnknown(data['disease_id']!, _diseaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_diseaseIdMeta);
    }
    if (data.containsKey('keyword')) {
      context.handle(
        _keywordMeta,
        keyword.isAcceptableOrUnknown(data['keyword']!, _keywordMeta),
      );
    } else if (isInserting) {
      context.missing(_keywordMeta);
    }
    if (data.containsKey('normalized_keyword')) {
      context.handle(
        _normalizedKeywordMeta,
        normalizedKeyword.isAcceptableOrUnknown(
          data['normalized_keyword']!,
          _normalizedKeywordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedKeywordMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {diseaseId, normalizedKeyword};
  @override
  DiseaseKeywordRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DiseaseKeywordRow(
      diseaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disease_id'],
      )!,
      keyword: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}keyword'],
      )!,
      normalizedKeyword: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_keyword'],
      )!,
    );
  }

  @override
  $DiseaseKeywordsTable createAlias(String alias) {
    return $DiseaseKeywordsTable(attachedDatabase, alias);
  }
}

class DiseaseKeywordRow extends DataClass
    implements Insertable<DiseaseKeywordRow> {
  final int diseaseId;
  final String keyword;
  final String normalizedKeyword;
  const DiseaseKeywordRow({
    required this.diseaseId,
    required this.keyword,
    required this.normalizedKeyword,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['disease_id'] = Variable<int>(diseaseId);
    map['keyword'] = Variable<String>(keyword);
    map['normalized_keyword'] = Variable<String>(normalizedKeyword);
    return map;
  }

  DiseaseKeywordsCompanion toCompanion(bool nullToAbsent) {
    return DiseaseKeywordsCompanion(
      diseaseId: Value(diseaseId),
      keyword: Value(keyword),
      normalizedKeyword: Value(normalizedKeyword),
    );
  }

  factory DiseaseKeywordRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DiseaseKeywordRow(
      diseaseId: serializer.fromJson<int>(json['diseaseId']),
      keyword: serializer.fromJson<String>(json['keyword']),
      normalizedKeyword: serializer.fromJson<String>(json['normalizedKeyword']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'diseaseId': serializer.toJson<int>(diseaseId),
      'keyword': serializer.toJson<String>(keyword),
      'normalizedKeyword': serializer.toJson<String>(normalizedKeyword),
    };
  }

  DiseaseKeywordRow copyWith({
    int? diseaseId,
    String? keyword,
    String? normalizedKeyword,
  }) => DiseaseKeywordRow(
    diseaseId: diseaseId ?? this.diseaseId,
    keyword: keyword ?? this.keyword,
    normalizedKeyword: normalizedKeyword ?? this.normalizedKeyword,
  );
  DiseaseKeywordRow copyWithCompanion(DiseaseKeywordsCompanion data) {
    return DiseaseKeywordRow(
      diseaseId: data.diseaseId.present ? data.diseaseId.value : this.diseaseId,
      keyword: data.keyword.present ? data.keyword.value : this.keyword,
      normalizedKeyword: data.normalizedKeyword.present
          ? data.normalizedKeyword.value
          : this.normalizedKeyword,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DiseaseKeywordRow(')
          ..write('diseaseId: $diseaseId, ')
          ..write('keyword: $keyword, ')
          ..write('normalizedKeyword: $normalizedKeyword')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(diseaseId, keyword, normalizedKeyword);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DiseaseKeywordRow &&
          other.diseaseId == this.diseaseId &&
          other.keyword == this.keyword &&
          other.normalizedKeyword == this.normalizedKeyword);
}

class DiseaseKeywordsCompanion extends UpdateCompanion<DiseaseKeywordRow> {
  final Value<int> diseaseId;
  final Value<String> keyword;
  final Value<String> normalizedKeyword;
  final Value<int> rowid;
  const DiseaseKeywordsCompanion({
    this.diseaseId = const Value.absent(),
    this.keyword = const Value.absent(),
    this.normalizedKeyword = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DiseaseKeywordsCompanion.insert({
    required int diseaseId,
    required String keyword,
    required String normalizedKeyword,
    this.rowid = const Value.absent(),
  }) : diseaseId = Value(diseaseId),
       keyword = Value(keyword),
       normalizedKeyword = Value(normalizedKeyword);
  static Insertable<DiseaseKeywordRow> custom({
    Expression<int>? diseaseId,
    Expression<String>? keyword,
    Expression<String>? normalizedKeyword,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (diseaseId != null) 'disease_id': diseaseId,
      if (keyword != null) 'keyword': keyword,
      if (normalizedKeyword != null) 'normalized_keyword': normalizedKeyword,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DiseaseKeywordsCompanion copyWith({
    Value<int>? diseaseId,
    Value<String>? keyword,
    Value<String>? normalizedKeyword,
    Value<int>? rowid,
  }) {
    return DiseaseKeywordsCompanion(
      diseaseId: diseaseId ?? this.diseaseId,
      keyword: keyword ?? this.keyword,
      normalizedKeyword: normalizedKeyword ?? this.normalizedKeyword,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (diseaseId.present) {
      map['disease_id'] = Variable<int>(diseaseId.value);
    }
    if (keyword.present) {
      map['keyword'] = Variable<String>(keyword.value);
    }
    if (normalizedKeyword.present) {
      map['normalized_keyword'] = Variable<String>(normalizedKeyword.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DiseaseKeywordsCompanion(')
          ..write('diseaseId: $diseaseId, ')
          ..write('keyword: $keyword, ')
          ..write('normalizedKeyword: $normalizedKeyword, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MedicinesTable extends Medicines
    with TableInfo<$MedicinesTable, MedicineRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MedicinesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _genericNameMeta = const VerificationMeta(
    'genericName',
  );
  @override
  late final GeneratedColumn<String> genericName = GeneratedColumn<String>(
    'generic_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedGenericNameMeta =
      const VerificationMeta('normalizedGenericName');
  @override
  late final GeneratedColumn<String> normalizedGenericName =
      GeneratedColumn<String>(
        'normalized_generic_name',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    normalizedName,
    genericName,
    normalizedGenericName,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'medicines';
  @override
  VerificationContext validateIntegrity(
    Insertable<MedicineRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('generic_name')) {
      context.handle(
        _genericNameMeta,
        genericName.isAcceptableOrUnknown(
          data['generic_name']!,
          _genericNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_genericNameMeta);
    }
    if (data.containsKey('normalized_generic_name')) {
      context.handle(
        _normalizedGenericNameMeta,
        normalizedGenericName.isAcceptableOrUnknown(
          data['normalized_generic_name']!,
          _normalizedGenericNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedGenericNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MedicineRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MedicineRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      genericName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}generic_name'],
      )!,
      normalizedGenericName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_generic_name'],
      )!,
    );
  }

  @override
  $MedicinesTable createAlias(String alias) {
    return $MedicinesTable(attachedDatabase, alias);
  }
}

class MedicineRow extends DataClass implements Insertable<MedicineRow> {
  final int id;
  final String name;
  final String normalizedName;
  final String genericName;
  final String normalizedGenericName;
  const MedicineRow({
    required this.id,
    required this.name,
    required this.normalizedName,
    required this.genericName,
    required this.normalizedGenericName,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['normalized_name'] = Variable<String>(normalizedName);
    map['generic_name'] = Variable<String>(genericName);
    map['normalized_generic_name'] = Variable<String>(normalizedGenericName);
    return map;
  }

  MedicinesCompanion toCompanion(bool nullToAbsent) {
    return MedicinesCompanion(
      id: Value(id),
      name: Value(name),
      normalizedName: Value(normalizedName),
      genericName: Value(genericName),
      normalizedGenericName: Value(normalizedGenericName),
    );
  }

  factory MedicineRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MedicineRow(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      genericName: serializer.fromJson<String>(json['genericName']),
      normalizedGenericName: serializer.fromJson<String>(
        json['normalizedGenericName'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'genericName': serializer.toJson<String>(genericName),
      'normalizedGenericName': serializer.toJson<String>(normalizedGenericName),
    };
  }

  MedicineRow copyWith({
    int? id,
    String? name,
    String? normalizedName,
    String? genericName,
    String? normalizedGenericName,
  }) => MedicineRow(
    id: id ?? this.id,
    name: name ?? this.name,
    normalizedName: normalizedName ?? this.normalizedName,
    genericName: genericName ?? this.genericName,
    normalizedGenericName: normalizedGenericName ?? this.normalizedGenericName,
  );
  MedicineRow copyWithCompanion(MedicinesCompanion data) {
    return MedicineRow(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      genericName: data.genericName.present
          ? data.genericName.value
          : this.genericName,
      normalizedGenericName: data.normalizedGenericName.present
          ? data.normalizedGenericName.value
          : this.normalizedGenericName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MedicineRow(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('genericName: $genericName, ')
          ..write('normalizedGenericName: $normalizedGenericName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, normalizedName, genericName, normalizedGenericName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MedicineRow &&
          other.id == this.id &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.genericName == this.genericName &&
          other.normalizedGenericName == this.normalizedGenericName);
}

class MedicinesCompanion extends UpdateCompanion<MedicineRow> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> normalizedName;
  final Value<String> genericName;
  final Value<String> normalizedGenericName;
  const MedicinesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.genericName = const Value.absent(),
    this.normalizedGenericName = const Value.absent(),
  });
  MedicinesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String normalizedName,
    required String genericName,
    required String normalizedGenericName,
  }) : name = Value(name),
       normalizedName = Value(normalizedName),
       genericName = Value(genericName),
       normalizedGenericName = Value(normalizedGenericName);
  static Insertable<MedicineRow> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<String>? genericName,
    Expression<String>? normalizedGenericName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (genericName != null) 'generic_name': genericName,
      if (normalizedGenericName != null)
        'normalized_generic_name': normalizedGenericName,
    });
  }

  MedicinesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String>? normalizedName,
    Value<String>? genericName,
    Value<String>? normalizedGenericName,
  }) {
    return MedicinesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      genericName: genericName ?? this.genericName,
      normalizedGenericName:
          normalizedGenericName ?? this.normalizedGenericName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (genericName.present) {
      map['generic_name'] = Variable<String>(genericName.value);
    }
    if (normalizedGenericName.present) {
      map['normalized_generic_name'] = Variable<String>(
        normalizedGenericName.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MedicinesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('genericName: $genericName, ')
          ..write('normalizedGenericName: $normalizedGenericName')
          ..write(')'))
        .toString();
  }
}

class $TreatmentRecommendationsTable extends TreatmentRecommendations
    with TableInfo<$TreatmentRecommendationsTable, TreatmentRecommendationRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TreatmentRecommendationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _diseaseIdMeta = const VerificationMeta(
    'diseaseId',
  );
  @override
  late final GeneratedColumn<int> diseaseId = GeneratedColumn<int>(
    'disease_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES diseases (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _medicineIdMeta = const VerificationMeta(
    'medicineId',
  );
  @override
  late final GeneratedColumn<int> medicineId = GeneratedColumn<int>(
    'medicine_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES medicines (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _doseMeta = const VerificationMeta('dose');
  @override
  late final GeneratedColumn<String> dose = GeneratedColumn<String>(
    'dose',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _frequencyMeta = const VerificationMeta(
    'frequency',
  );
  @override
  late final GeneratedColumn<String> frequency = GeneratedColumn<String>(
    'frequency',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _durationMeta = const VerificationMeta(
    'duration',
  );
  @override
  late final GeneratedColumn<String> duration = GeneratedColumn<String>(
    'duration',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _normalizedSearchTextMeta =
      const VerificationMeta('normalizedSearchText');
  @override
  late final GeneratedColumn<String> normalizedSearchText =
      GeneratedColumn<String>(
        'normalized_search_text',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    diseaseId,
    medicineId,
    type,
    dose,
    frequency,
    duration,
    normalizedSearchText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recommendations';
  @override
  VerificationContext validateIntegrity(
    Insertable<TreatmentRecommendationRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('disease_id')) {
      context.handle(
        _diseaseIdMeta,
        diseaseId.isAcceptableOrUnknown(data['disease_id']!, _diseaseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_diseaseIdMeta);
    }
    if (data.containsKey('medicine_id')) {
      context.handle(
        _medicineIdMeta,
        medicineId.isAcceptableOrUnknown(data['medicine_id']!, _medicineIdMeta),
      );
    } else if (isInserting) {
      context.missing(_medicineIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('dose')) {
      context.handle(
        _doseMeta,
        dose.isAcceptableOrUnknown(data['dose']!, _doseMeta),
      );
    } else if (isInserting) {
      context.missing(_doseMeta);
    }
    if (data.containsKey('frequency')) {
      context.handle(
        _frequencyMeta,
        frequency.isAcceptableOrUnknown(data['frequency']!, _frequencyMeta),
      );
    } else if (isInserting) {
      context.missing(_frequencyMeta);
    }
    if (data.containsKey('duration')) {
      context.handle(
        _durationMeta,
        duration.isAcceptableOrUnknown(data['duration']!, _durationMeta),
      );
    } else if (isInserting) {
      context.missing(_durationMeta);
    }
    if (data.containsKey('normalized_search_text')) {
      context.handle(
        _normalizedSearchTextMeta,
        normalizedSearchText.isAcceptableOrUnknown(
          data['normalized_search_text']!,
          _normalizedSearchTextMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedSearchTextMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TreatmentRecommendationRow map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TreatmentRecommendationRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      diseaseId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}disease_id'],
      )!,
      medicineId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}medicine_id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      dose: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dose'],
      )!,
      frequency: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}frequency'],
      )!,
      duration: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}duration'],
      )!,
      normalizedSearchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_search_text'],
      )!,
    );
  }

  @override
  $TreatmentRecommendationsTable createAlias(String alias) {
    return $TreatmentRecommendationsTable(attachedDatabase, alias);
  }
}

class TreatmentRecommendationRow extends DataClass
    implements Insertable<TreatmentRecommendationRow> {
  final int id;
  final int diseaseId;
  final int medicineId;
  final String type;
  final String dose;
  final String frequency;
  final String duration;
  final String normalizedSearchText;
  const TreatmentRecommendationRow({
    required this.id,
    required this.diseaseId,
    required this.medicineId,
    required this.type,
    required this.dose,
    required this.frequency,
    required this.duration,
    required this.normalizedSearchText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['disease_id'] = Variable<int>(diseaseId);
    map['medicine_id'] = Variable<int>(medicineId);
    map['type'] = Variable<String>(type);
    map['dose'] = Variable<String>(dose);
    map['frequency'] = Variable<String>(frequency);
    map['duration'] = Variable<String>(duration);
    map['normalized_search_text'] = Variable<String>(normalizedSearchText);
    return map;
  }

  TreatmentRecommendationsCompanion toCompanion(bool nullToAbsent) {
    return TreatmentRecommendationsCompanion(
      id: Value(id),
      diseaseId: Value(diseaseId),
      medicineId: Value(medicineId),
      type: Value(type),
      dose: Value(dose),
      frequency: Value(frequency),
      duration: Value(duration),
      normalizedSearchText: Value(normalizedSearchText),
    );
  }

  factory TreatmentRecommendationRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TreatmentRecommendationRow(
      id: serializer.fromJson<int>(json['id']),
      diseaseId: serializer.fromJson<int>(json['diseaseId']),
      medicineId: serializer.fromJson<int>(json['medicineId']),
      type: serializer.fromJson<String>(json['type']),
      dose: serializer.fromJson<String>(json['dose']),
      frequency: serializer.fromJson<String>(json['frequency']),
      duration: serializer.fromJson<String>(json['duration']),
      normalizedSearchText: serializer.fromJson<String>(
        json['normalizedSearchText'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'diseaseId': serializer.toJson<int>(diseaseId),
      'medicineId': serializer.toJson<int>(medicineId),
      'type': serializer.toJson<String>(type),
      'dose': serializer.toJson<String>(dose),
      'frequency': serializer.toJson<String>(frequency),
      'duration': serializer.toJson<String>(duration),
      'normalizedSearchText': serializer.toJson<String>(normalizedSearchText),
    };
  }

  TreatmentRecommendationRow copyWith({
    int? id,
    int? diseaseId,
    int? medicineId,
    String? type,
    String? dose,
    String? frequency,
    String? duration,
    String? normalizedSearchText,
  }) => TreatmentRecommendationRow(
    id: id ?? this.id,
    diseaseId: diseaseId ?? this.diseaseId,
    medicineId: medicineId ?? this.medicineId,
    type: type ?? this.type,
    dose: dose ?? this.dose,
    frequency: frequency ?? this.frequency,
    duration: duration ?? this.duration,
    normalizedSearchText: normalizedSearchText ?? this.normalizedSearchText,
  );
  TreatmentRecommendationRow copyWithCompanion(
    TreatmentRecommendationsCompanion data,
  ) {
    return TreatmentRecommendationRow(
      id: data.id.present ? data.id.value : this.id,
      diseaseId: data.diseaseId.present ? data.diseaseId.value : this.diseaseId,
      medicineId: data.medicineId.present
          ? data.medicineId.value
          : this.medicineId,
      type: data.type.present ? data.type.value : this.type,
      dose: data.dose.present ? data.dose.value : this.dose,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      duration: data.duration.present ? data.duration.value : this.duration,
      normalizedSearchText: data.normalizedSearchText.present
          ? data.normalizedSearchText.value
          : this.normalizedSearchText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentRecommendationRow(')
          ..write('id: $id, ')
          ..write('diseaseId: $diseaseId, ')
          ..write('medicineId: $medicineId, ')
          ..write('type: $type, ')
          ..write('dose: $dose, ')
          ..write('frequency: $frequency, ')
          ..write('duration: $duration, ')
          ..write('normalizedSearchText: $normalizedSearchText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    diseaseId,
    medicineId,
    type,
    dose,
    frequency,
    duration,
    normalizedSearchText,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TreatmentRecommendationRow &&
          other.id == this.id &&
          other.diseaseId == this.diseaseId &&
          other.medicineId == this.medicineId &&
          other.type == this.type &&
          other.dose == this.dose &&
          other.frequency == this.frequency &&
          other.duration == this.duration &&
          other.normalizedSearchText == this.normalizedSearchText);
}

class TreatmentRecommendationsCompanion
    extends UpdateCompanion<TreatmentRecommendationRow> {
  final Value<int> id;
  final Value<int> diseaseId;
  final Value<int> medicineId;
  final Value<String> type;
  final Value<String> dose;
  final Value<String> frequency;
  final Value<String> duration;
  final Value<String> normalizedSearchText;
  const TreatmentRecommendationsCompanion({
    this.id = const Value.absent(),
    this.diseaseId = const Value.absent(),
    this.medicineId = const Value.absent(),
    this.type = const Value.absent(),
    this.dose = const Value.absent(),
    this.frequency = const Value.absent(),
    this.duration = const Value.absent(),
    this.normalizedSearchText = const Value.absent(),
  });
  TreatmentRecommendationsCompanion.insert({
    this.id = const Value.absent(),
    required int diseaseId,
    required int medicineId,
    required String type,
    required String dose,
    required String frequency,
    required String duration,
    required String normalizedSearchText,
  }) : diseaseId = Value(diseaseId),
       medicineId = Value(medicineId),
       type = Value(type),
       dose = Value(dose),
       frequency = Value(frequency),
       duration = Value(duration),
       normalizedSearchText = Value(normalizedSearchText);
  static Insertable<TreatmentRecommendationRow> custom({
    Expression<int>? id,
    Expression<int>? diseaseId,
    Expression<int>? medicineId,
    Expression<String>? type,
    Expression<String>? dose,
    Expression<String>? frequency,
    Expression<String>? duration,
    Expression<String>? normalizedSearchText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (diseaseId != null) 'disease_id': diseaseId,
      if (medicineId != null) 'medicine_id': medicineId,
      if (type != null) 'type': type,
      if (dose != null) 'dose': dose,
      if (frequency != null) 'frequency': frequency,
      if (duration != null) 'duration': duration,
      if (normalizedSearchText != null)
        'normalized_search_text': normalizedSearchText,
    });
  }

  TreatmentRecommendationsCompanion copyWith({
    Value<int>? id,
    Value<int>? diseaseId,
    Value<int>? medicineId,
    Value<String>? type,
    Value<String>? dose,
    Value<String>? frequency,
    Value<String>? duration,
    Value<String>? normalizedSearchText,
  }) {
    return TreatmentRecommendationsCompanion(
      id: id ?? this.id,
      diseaseId: diseaseId ?? this.diseaseId,
      medicineId: medicineId ?? this.medicineId,
      type: type ?? this.type,
      dose: dose ?? this.dose,
      frequency: frequency ?? this.frequency,
      duration: duration ?? this.duration,
      normalizedSearchText: normalizedSearchText ?? this.normalizedSearchText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (diseaseId.present) {
      map['disease_id'] = Variable<int>(diseaseId.value);
    }
    if (medicineId.present) {
      map['medicine_id'] = Variable<int>(medicineId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (dose.present) {
      map['dose'] = Variable<String>(dose.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(frequency.value);
    }
    if (duration.present) {
      map['duration'] = Variable<String>(duration.value);
    }
    if (normalizedSearchText.present) {
      map['normalized_search_text'] = Variable<String>(
        normalizedSearchText.value,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TreatmentRecommendationsCompanion(')
          ..write('id: $id, ')
          ..write('diseaseId: $diseaseId, ')
          ..write('medicineId: $medicineId, ')
          ..write('type: $type, ')
          ..write('dose: $dose, ')
          ..write('frequency: $frequency, ')
          ..write('duration: $duration, ')
          ..write('normalizedSearchText: $normalizedSearchText')
          ..write(')'))
        .toString();
  }
}

class $SyncMetadataTable extends SyncMetadata
    with TableInfo<$SyncMetadataTable, SyncMetadataRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncMetadataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _datasetVersionMeta = const VerificationMeta(
    'datasetVersion',
  );
  @override
  late final GeneratedColumn<int> datasetVersion = GeneratedColumn<int>(
    'dataset_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lastSuccessfulSyncMeta =
      const VerificationMeta('lastSuccessfulSync');
  @override
  late final GeneratedColumn<DateTime> lastSuccessfulSync =
      GeneratedColumn<DateTime>(
        'last_successful_sync',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    key,
    datasetVersion,
    lastSuccessfulSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_metadata';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncMetadataRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('dataset_version')) {
      context.handle(
        _datasetVersionMeta,
        datasetVersion.isAcceptableOrUnknown(
          data['dataset_version']!,
          _datasetVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_datasetVersionMeta);
    }
    if (data.containsKey('last_successful_sync')) {
      context.handle(
        _lastSuccessfulSyncMeta,
        lastSuccessfulSync.isAcceptableOrUnknown(
          data['last_successful_sync']!,
          _lastSuccessfulSyncMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastSuccessfulSyncMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  SyncMetadataRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncMetadataRow(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      datasetVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}dataset_version'],
      )!,
      lastSuccessfulSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_successful_sync'],
      )!,
    );
  }

  @override
  $SyncMetadataTable createAlias(String alias) {
    return $SyncMetadataTable(attachedDatabase, alias);
  }
}

class SyncMetadataRow extends DataClass implements Insertable<SyncMetadataRow> {
  final String key;
  final int datasetVersion;
  final DateTime lastSuccessfulSync;
  const SyncMetadataRow({
    required this.key,
    required this.datasetVersion,
    required this.lastSuccessfulSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['dataset_version'] = Variable<int>(datasetVersion);
    map['last_successful_sync'] = Variable<DateTime>(lastSuccessfulSync);
    return map;
  }

  SyncMetadataCompanion toCompanion(bool nullToAbsent) {
    return SyncMetadataCompanion(
      key: Value(key),
      datasetVersion: Value(datasetVersion),
      lastSuccessfulSync: Value(lastSuccessfulSync),
    );
  }

  factory SyncMetadataRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncMetadataRow(
      key: serializer.fromJson<String>(json['key']),
      datasetVersion: serializer.fromJson<int>(json['datasetVersion']),
      lastSuccessfulSync: serializer.fromJson<DateTime>(
        json['lastSuccessfulSync'],
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'datasetVersion': serializer.toJson<int>(datasetVersion),
      'lastSuccessfulSync': serializer.toJson<DateTime>(lastSuccessfulSync),
    };
  }

  SyncMetadataRow copyWith({
    String? key,
    int? datasetVersion,
    DateTime? lastSuccessfulSync,
  }) => SyncMetadataRow(
    key: key ?? this.key,
    datasetVersion: datasetVersion ?? this.datasetVersion,
    lastSuccessfulSync: lastSuccessfulSync ?? this.lastSuccessfulSync,
  );
  SyncMetadataRow copyWithCompanion(SyncMetadataCompanion data) {
    return SyncMetadataRow(
      key: data.key.present ? data.key.value : this.key,
      datasetVersion: data.datasetVersion.present
          ? data.datasetVersion.value
          : this.datasetVersion,
      lastSuccessfulSync: data.lastSuccessfulSync.present
          ? data.lastSuccessfulSync.value
          : this.lastSuccessfulSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataRow(')
          ..write('key: $key, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('lastSuccessfulSync: $lastSuccessfulSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, datasetVersion, lastSuccessfulSync);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncMetadataRow &&
          other.key == this.key &&
          other.datasetVersion == this.datasetVersion &&
          other.lastSuccessfulSync == this.lastSuccessfulSync);
}

class SyncMetadataCompanion extends UpdateCompanion<SyncMetadataRow> {
  final Value<String> key;
  final Value<int> datasetVersion;
  final Value<DateTime> lastSuccessfulSync;
  final Value<int> rowid;
  const SyncMetadataCompanion({
    this.key = const Value.absent(),
    this.datasetVersion = const Value.absent(),
    this.lastSuccessfulSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SyncMetadataCompanion.insert({
    required String key,
    required int datasetVersion,
    required DateTime lastSuccessfulSync,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       datasetVersion = Value(datasetVersion),
       lastSuccessfulSync = Value(lastSuccessfulSync);
  static Insertable<SyncMetadataRow> custom({
    Expression<String>? key,
    Expression<int>? datasetVersion,
    Expression<DateTime>? lastSuccessfulSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (datasetVersion != null) 'dataset_version': datasetVersion,
      if (lastSuccessfulSync != null)
        'last_successful_sync': lastSuccessfulSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SyncMetadataCompanion copyWith({
    Value<String>? key,
    Value<int>? datasetVersion,
    Value<DateTime>? lastSuccessfulSync,
    Value<int>? rowid,
  }) {
    return SyncMetadataCompanion(
      key: key ?? this.key,
      datasetVersion: datasetVersion ?? this.datasetVersion,
      lastSuccessfulSync: lastSuccessfulSync ?? this.lastSuccessfulSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (datasetVersion.present) {
      map['dataset_version'] = Variable<int>(datasetVersion.value);
    }
    if (lastSuccessfulSync.present) {
      map['last_successful_sync'] = Variable<DateTime>(
        lastSuccessfulSync.value,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncMetadataCompanion(')
          ..write('key: $key, ')
          ..write('datasetVersion: $datasetVersion, ')
          ..write('lastSuccessfulSync: $lastSuccessfulSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ClinicalDatabase extends GeneratedDatabase {
  _$ClinicalDatabase(QueryExecutor e) : super(e);
  $ClinicalDatabaseManager get managers => $ClinicalDatabaseManager(this);
  late final $DiseasesTable diseases = $DiseasesTable(this);
  late final $DiseaseKeywordsTable diseaseKeywords = $DiseaseKeywordsTable(
    this,
  );
  late final $MedicinesTable medicines = $MedicinesTable(this);
  late final $TreatmentRecommendationsTable treatmentRecommendations =
      $TreatmentRecommendationsTable(this);
  late final $SyncMetadataTable syncMetadata = $SyncMetadataTable(this);
  late final Index diseasesByNormalizedName = Index(
    'diseases_by_normalized_name',
    'CREATE INDEX diseases_by_normalized_name ON diseases (normalized_name)',
  );
  late final Index diseaseKeywordsByNormalizedKeyword = Index(
    'disease_keywords_by_normalized_keyword',
    'CREATE INDEX disease_keywords_by_normalized_keyword ON disease_keywords (normalized_keyword)',
  );
  late final Index medicinesByNormalizedName = Index(
    'medicines_by_normalized_name',
    'CREATE INDEX medicines_by_normalized_name ON medicines (normalized_name)',
  );
  late final Index medicinesByNormalizedGenericName = Index(
    'medicines_by_normalized_generic_name',
    'CREATE INDEX medicines_by_normalized_generic_name ON medicines (normalized_generic_name)',
  );
  late final Index recommendationsByDisease = Index(
    'recommendations_by_disease',
    'CREATE INDEX recommendations_by_disease ON recommendations (disease_id)',
  );
  late final Index recommendationsByMedicine = Index(
    'recommendations_by_medicine',
    'CREATE INDEX recommendations_by_medicine ON recommendations (medicine_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    diseases,
    diseaseKeywords,
    medicines,
    treatmentRecommendations,
    syncMetadata,
    diseasesByNormalizedName,
    diseaseKeywordsByNormalizedKeyword,
    medicinesByNormalizedName,
    medicinesByNormalizedGenericName,
    recommendationsByDisease,
    recommendationsByMedicine,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'diseases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('disease_keywords', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'diseases',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recommendations', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'medicines',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('recommendations', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$DiseasesTableCreateCompanionBuilder =
    DiseasesCompanion Function({
      Value<int> id,
      required String name,
      required String normalizedName,
      required String category,
    });
typedef $$DiseasesTableUpdateCompanionBuilder =
    DiseasesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> normalizedName,
      Value<String> category,
    });

final class $$DiseasesTableReferences
    extends BaseReferences<_$ClinicalDatabase, $DiseasesTable, DiseaseRow> {
  $$DiseasesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DiseaseKeywordsTable, List<DiseaseKeywordRow>>
  _diseaseKeywordsRefsTable(_$ClinicalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.diseaseKeywords,
        aliasName: 'diseases__id__disease_keywords__disease_id',
      );

  $$DiseaseKeywordsTableProcessedTableManager get diseaseKeywordsRefs {
    final manager = $$DiseaseKeywordsTableTableManager(
      $_db,
      $_db.diseaseKeywords,
    ).filter((f) => f.diseaseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _diseaseKeywordsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $TreatmentRecommendationsTable,
    List<TreatmentRecommendationRow>
  >
  _treatmentRecommendationsRefsTable(_$ClinicalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.treatmentRecommendations,
        aliasName: 'diseases__id__recommendations__disease_id',
      );

  $$TreatmentRecommendationsTableProcessedTableManager
  get treatmentRecommendationsRefs {
    final manager = $$TreatmentRecommendationsTableTableManager(
      $_db,
      $_db.treatmentRecommendations,
    ).filter((f) => f.diseaseId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _treatmentRecommendationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$DiseasesTableFilterComposer
    extends Composer<_$ClinicalDatabase, $DiseasesTable> {
  $$DiseasesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> diseaseKeywordsRefs(
    Expression<bool> Function($$DiseaseKeywordsTableFilterComposer f) f,
  ) {
    final $$DiseaseKeywordsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.diseaseKeywords,
      getReferencedColumn: (t) => t.diseaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiseaseKeywordsTableFilterComposer(
            $db: $db,
            $table: $db.diseaseKeywords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> treatmentRecommendationsRefs(
    Expression<bool> Function($$TreatmentRecommendationsTableFilterComposer f)
    f,
  ) {
    final $$TreatmentRecommendationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.treatmentRecommendations,
          getReferencedColumn: (t) => t.diseaseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TreatmentRecommendationsTableFilterComposer(
                $db: $db,
                $table: $db.treatmentRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DiseasesTableOrderingComposer
    extends Composer<_$ClinicalDatabase, $DiseasesTable> {
  $$DiseasesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DiseasesTableAnnotationComposer
    extends Composer<_$ClinicalDatabase, $DiseasesTable> {
  $$DiseasesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  Expression<T> diseaseKeywordsRefs<T extends Object>(
    Expression<T> Function($$DiseaseKeywordsTableAnnotationComposer a) f,
  ) {
    final $$DiseaseKeywordsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.diseaseKeywords,
      getReferencedColumn: (t) => t.diseaseId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiseaseKeywordsTableAnnotationComposer(
            $db: $db,
            $table: $db.diseaseKeywords,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> treatmentRecommendationsRefs<T extends Object>(
    Expression<T> Function($$TreatmentRecommendationsTableAnnotationComposer a)
    f,
  ) {
    final $$TreatmentRecommendationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.treatmentRecommendations,
          getReferencedColumn: (t) => t.diseaseId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TreatmentRecommendationsTableAnnotationComposer(
                $db: $db,
                $table: $db.treatmentRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$DiseasesTableTableManager
    extends
        RootTableManager<
          _$ClinicalDatabase,
          $DiseasesTable,
          DiseaseRow,
          $$DiseasesTableFilterComposer,
          $$DiseasesTableOrderingComposer,
          $$DiseasesTableAnnotationComposer,
          $$DiseasesTableCreateCompanionBuilder,
          $$DiseasesTableUpdateCompanionBuilder,
          (DiseaseRow, $$DiseasesTableReferences),
          DiseaseRow,
          PrefetchHooks Function({
            bool diseaseKeywordsRefs,
            bool treatmentRecommendationsRefs,
          })
        > {
  $$DiseasesTableTableManager(_$ClinicalDatabase db, $DiseasesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiseasesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiseasesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiseasesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String> category = const Value.absent(),
              }) => DiseasesCompanion(
                id: id,
                name: name,
                normalizedName: normalizedName,
                category: category,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String normalizedName,
                required String category,
              }) => DiseasesCompanion.insert(
                id: id,
                name: name,
                normalizedName: normalizedName,
                category: category,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DiseasesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                diseaseKeywordsRefs = false,
                treatmentRecommendationsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (diseaseKeywordsRefs) db.diseaseKeywords,
                    if (treatmentRecommendationsRefs)
                      db.treatmentRecommendations,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (diseaseKeywordsRefs)
                        await $_getPrefetchedData<
                          DiseaseRow,
                          $DiseasesTable,
                          DiseaseKeywordRow
                        >(
                          currentTable: table,
                          referencedTable: $$DiseasesTableReferences
                              ._diseaseKeywordsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DiseasesTableReferences(
                                db,
                                table,
                                p0,
                              ).diseaseKeywordsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.diseaseId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (treatmentRecommendationsRefs)
                        await $_getPrefetchedData<
                          DiseaseRow,
                          $DiseasesTable,
                          TreatmentRecommendationRow
                        >(
                          currentTable: table,
                          referencedTable: $$DiseasesTableReferences
                              ._treatmentRecommendationsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$DiseasesTableReferences(
                                db,
                                table,
                                p0,
                              ).treatmentRecommendationsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.diseaseId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$DiseasesTableProcessedTableManager =
    ProcessedTableManager<
      _$ClinicalDatabase,
      $DiseasesTable,
      DiseaseRow,
      $$DiseasesTableFilterComposer,
      $$DiseasesTableOrderingComposer,
      $$DiseasesTableAnnotationComposer,
      $$DiseasesTableCreateCompanionBuilder,
      $$DiseasesTableUpdateCompanionBuilder,
      (DiseaseRow, $$DiseasesTableReferences),
      DiseaseRow,
      PrefetchHooks Function({
        bool diseaseKeywordsRefs,
        bool treatmentRecommendationsRefs,
      })
    >;
typedef $$DiseaseKeywordsTableCreateCompanionBuilder =
    DiseaseKeywordsCompanion Function({
      required int diseaseId,
      required String keyword,
      required String normalizedKeyword,
      Value<int> rowid,
    });
typedef $$DiseaseKeywordsTableUpdateCompanionBuilder =
    DiseaseKeywordsCompanion Function({
      Value<int> diseaseId,
      Value<String> keyword,
      Value<String> normalizedKeyword,
      Value<int> rowid,
    });

final class $$DiseaseKeywordsTableReferences
    extends
        BaseReferences<
          _$ClinicalDatabase,
          $DiseaseKeywordsTable,
          DiseaseKeywordRow
        > {
  $$DiseaseKeywordsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DiseasesTable _diseaseIdTable(_$ClinicalDatabase db) =>
      db.diseases.createAlias('disease_keywords__disease_id__diseases__id');

  $$DiseasesTableProcessedTableManager get diseaseId {
    final $_column = $_itemColumn<int>('disease_id')!;

    final manager = $$DiseasesTableTableManager(
      $_db,
      $_db.diseases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_diseaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DiseaseKeywordsTableFilterComposer
    extends Composer<_$ClinicalDatabase, $DiseaseKeywordsTable> {
  $$DiseaseKeywordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get keyword => $composableBuilder(
    column: $table.keyword,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedKeyword => $composableBuilder(
    column: $table.normalizedKeyword,
    builder: (column) => ColumnFilters(column),
  );

  $$DiseasesTableFilterComposer get diseaseId {
    final $$DiseasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diseaseId,
      referencedTable: $db.diseases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiseasesTableFilterComposer(
            $db: $db,
            $table: $db.diseases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiseaseKeywordsTableOrderingComposer
    extends Composer<_$ClinicalDatabase, $DiseaseKeywordsTable> {
  $$DiseaseKeywordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get keyword => $composableBuilder(
    column: $table.keyword,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedKeyword => $composableBuilder(
    column: $table.normalizedKeyword,
    builder: (column) => ColumnOrderings(column),
  );

  $$DiseasesTableOrderingComposer get diseaseId {
    final $$DiseasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diseaseId,
      referencedTable: $db.diseases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiseasesTableOrderingComposer(
            $db: $db,
            $table: $db.diseases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiseaseKeywordsTableAnnotationComposer
    extends Composer<_$ClinicalDatabase, $DiseaseKeywordsTable> {
  $$DiseaseKeywordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get keyword =>
      $composableBuilder(column: $table.keyword, builder: (column) => column);

  GeneratedColumn<String> get normalizedKeyword => $composableBuilder(
    column: $table.normalizedKeyword,
    builder: (column) => column,
  );

  $$DiseasesTableAnnotationComposer get diseaseId {
    final $$DiseasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diseaseId,
      referencedTable: $db.diseases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiseasesTableAnnotationComposer(
            $db: $db,
            $table: $db.diseases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DiseaseKeywordsTableTableManager
    extends
        RootTableManager<
          _$ClinicalDatabase,
          $DiseaseKeywordsTable,
          DiseaseKeywordRow,
          $$DiseaseKeywordsTableFilterComposer,
          $$DiseaseKeywordsTableOrderingComposer,
          $$DiseaseKeywordsTableAnnotationComposer,
          $$DiseaseKeywordsTableCreateCompanionBuilder,
          $$DiseaseKeywordsTableUpdateCompanionBuilder,
          (DiseaseKeywordRow, $$DiseaseKeywordsTableReferences),
          DiseaseKeywordRow,
          PrefetchHooks Function({bool diseaseId})
        > {
  $$DiseaseKeywordsTableTableManager(
    _$ClinicalDatabase db,
    $DiseaseKeywordsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DiseaseKeywordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DiseaseKeywordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DiseaseKeywordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> diseaseId = const Value.absent(),
                Value<String> keyword = const Value.absent(),
                Value<String> normalizedKeyword = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DiseaseKeywordsCompanion(
                diseaseId: diseaseId,
                keyword: keyword,
                normalizedKeyword: normalizedKeyword,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int diseaseId,
                required String keyword,
                required String normalizedKeyword,
                Value<int> rowid = const Value.absent(),
              }) => DiseaseKeywordsCompanion.insert(
                diseaseId: diseaseId,
                keyword: keyword,
                normalizedKeyword: normalizedKeyword,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DiseaseKeywordsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({diseaseId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (diseaseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.diseaseId,
                                referencedTable:
                                    $$DiseaseKeywordsTableReferences
                                        ._diseaseIdTable(db),
                                referencedColumn:
                                    $$DiseaseKeywordsTableReferences
                                        ._diseaseIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DiseaseKeywordsTableProcessedTableManager =
    ProcessedTableManager<
      _$ClinicalDatabase,
      $DiseaseKeywordsTable,
      DiseaseKeywordRow,
      $$DiseaseKeywordsTableFilterComposer,
      $$DiseaseKeywordsTableOrderingComposer,
      $$DiseaseKeywordsTableAnnotationComposer,
      $$DiseaseKeywordsTableCreateCompanionBuilder,
      $$DiseaseKeywordsTableUpdateCompanionBuilder,
      (DiseaseKeywordRow, $$DiseaseKeywordsTableReferences),
      DiseaseKeywordRow,
      PrefetchHooks Function({bool diseaseId})
    >;
typedef $$MedicinesTableCreateCompanionBuilder =
    MedicinesCompanion Function({
      Value<int> id,
      required String name,
      required String normalizedName,
      required String genericName,
      required String normalizedGenericName,
    });
typedef $$MedicinesTableUpdateCompanionBuilder =
    MedicinesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String> normalizedName,
      Value<String> genericName,
      Value<String> normalizedGenericName,
    });

final class $$MedicinesTableReferences
    extends BaseReferences<_$ClinicalDatabase, $MedicinesTable, MedicineRow> {
  $$MedicinesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $TreatmentRecommendationsTable,
    List<TreatmentRecommendationRow>
  >
  _treatmentRecommendationsRefsTable(_$ClinicalDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.treatmentRecommendations,
        aliasName: 'medicines__id__recommendations__medicine_id',
      );

  $$TreatmentRecommendationsTableProcessedTableManager
  get treatmentRecommendationsRefs {
    final manager = $$TreatmentRecommendationsTableTableManager(
      $_db,
      $_db.treatmentRecommendations,
    ).filter((f) => f.medicineId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _treatmentRecommendationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MedicinesTableFilterComposer
    extends Composer<_$ClinicalDatabase, $MedicinesTable> {
  $$MedicinesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get genericName => $composableBuilder(
    column: $table.genericName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedGenericName => $composableBuilder(
    column: $table.normalizedGenericName,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> treatmentRecommendationsRefs(
    Expression<bool> Function($$TreatmentRecommendationsTableFilterComposer f)
    f,
  ) {
    final $$TreatmentRecommendationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.treatmentRecommendations,
          getReferencedColumn: (t) => t.medicineId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TreatmentRecommendationsTableFilterComposer(
                $db: $db,
                $table: $db.treatmentRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MedicinesTableOrderingComposer
    extends Composer<_$ClinicalDatabase, $MedicinesTable> {
  $$MedicinesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get genericName => $composableBuilder(
    column: $table.genericName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedGenericName => $composableBuilder(
    column: $table.normalizedGenericName,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MedicinesTableAnnotationComposer
    extends Composer<_$ClinicalDatabase, $MedicinesTable> {
  $$MedicinesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get genericName => $composableBuilder(
    column: $table.genericName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get normalizedGenericName => $composableBuilder(
    column: $table.normalizedGenericName,
    builder: (column) => column,
  );

  Expression<T> treatmentRecommendationsRefs<T extends Object>(
    Expression<T> Function($$TreatmentRecommendationsTableAnnotationComposer a)
    f,
  ) {
    final $$TreatmentRecommendationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.treatmentRecommendations,
          getReferencedColumn: (t) => t.medicineId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$TreatmentRecommendationsTableAnnotationComposer(
                $db: $db,
                $table: $db.treatmentRecommendations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$MedicinesTableTableManager
    extends
        RootTableManager<
          _$ClinicalDatabase,
          $MedicinesTable,
          MedicineRow,
          $$MedicinesTableFilterComposer,
          $$MedicinesTableOrderingComposer,
          $$MedicinesTableAnnotationComposer,
          $$MedicinesTableCreateCompanionBuilder,
          $$MedicinesTableUpdateCompanionBuilder,
          (MedicineRow, $$MedicinesTableReferences),
          MedicineRow,
          PrefetchHooks Function({bool treatmentRecommendationsRefs})
        > {
  $$MedicinesTableTableManager(_$ClinicalDatabase db, $MedicinesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MedicinesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MedicinesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MedicinesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<String> genericName = const Value.absent(),
                Value<String> normalizedGenericName = const Value.absent(),
              }) => MedicinesCompanion(
                id: id,
                name: name,
                normalizedName: normalizedName,
                genericName: genericName,
                normalizedGenericName: normalizedGenericName,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required String normalizedName,
                required String genericName,
                required String normalizedGenericName,
              }) => MedicinesCompanion.insert(
                id: id,
                name: name,
                normalizedName: normalizedName,
                genericName: genericName,
                normalizedGenericName: normalizedGenericName,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MedicinesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({treatmentRecommendationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (treatmentRecommendationsRefs) db.treatmentRecommendations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (treatmentRecommendationsRefs)
                    await $_getPrefetchedData<
                      MedicineRow,
                      $MedicinesTable,
                      TreatmentRecommendationRow
                    >(
                      currentTable: table,
                      referencedTable: $$MedicinesTableReferences
                          ._treatmentRecommendationsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$MedicinesTableReferences(
                            db,
                            table,
                            p0,
                          ).treatmentRecommendationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.medicineId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$MedicinesTableProcessedTableManager =
    ProcessedTableManager<
      _$ClinicalDatabase,
      $MedicinesTable,
      MedicineRow,
      $$MedicinesTableFilterComposer,
      $$MedicinesTableOrderingComposer,
      $$MedicinesTableAnnotationComposer,
      $$MedicinesTableCreateCompanionBuilder,
      $$MedicinesTableUpdateCompanionBuilder,
      (MedicineRow, $$MedicinesTableReferences),
      MedicineRow,
      PrefetchHooks Function({bool treatmentRecommendationsRefs})
    >;
typedef $$TreatmentRecommendationsTableCreateCompanionBuilder =
    TreatmentRecommendationsCompanion Function({
      Value<int> id,
      required int diseaseId,
      required int medicineId,
      required String type,
      required String dose,
      required String frequency,
      required String duration,
      required String normalizedSearchText,
    });
typedef $$TreatmentRecommendationsTableUpdateCompanionBuilder =
    TreatmentRecommendationsCompanion Function({
      Value<int> id,
      Value<int> diseaseId,
      Value<int> medicineId,
      Value<String> type,
      Value<String> dose,
      Value<String> frequency,
      Value<String> duration,
      Value<String> normalizedSearchText,
    });

final class $$TreatmentRecommendationsTableReferences
    extends
        BaseReferences<
          _$ClinicalDatabase,
          $TreatmentRecommendationsTable,
          TreatmentRecommendationRow
        > {
  $$TreatmentRecommendationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $DiseasesTable _diseaseIdTable(_$ClinicalDatabase db) =>
      db.diseases.createAlias('recommendations__disease_id__diseases__id');

  $$DiseasesTableProcessedTableManager get diseaseId {
    final $_column = $_itemColumn<int>('disease_id')!;

    final manager = $$DiseasesTableTableManager(
      $_db,
      $_db.diseases,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_diseaseIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MedicinesTable _medicineIdTable(_$ClinicalDatabase db) =>
      db.medicines.createAlias('recommendations__medicine_id__medicines__id');

  $$MedicinesTableProcessedTableManager get medicineId {
    final $_column = $_itemColumn<int>('medicine_id')!;

    final manager = $$MedicinesTableTableManager(
      $_db,
      $_db.medicines,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_medicineIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TreatmentRecommendationsTableFilterComposer
    extends Composer<_$ClinicalDatabase, $TreatmentRecommendationsTable> {
  $$TreatmentRecommendationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedSearchText => $composableBuilder(
    column: $table.normalizedSearchText,
    builder: (column) => ColumnFilters(column),
  );

  $$DiseasesTableFilterComposer get diseaseId {
    final $$DiseasesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diseaseId,
      referencedTable: $db.diseases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiseasesTableFilterComposer(
            $db: $db,
            $table: $db.diseases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableFilterComposer get medicineId {
    final $$MedicinesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicinesTableFilterComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreatmentRecommendationsTableOrderingComposer
    extends Composer<_$ClinicalDatabase, $TreatmentRecommendationsTable> {
  $$TreatmentRecommendationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dose => $composableBuilder(
    column: $table.dose,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get duration => $composableBuilder(
    column: $table.duration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedSearchText => $composableBuilder(
    column: $table.normalizedSearchText,
    builder: (column) => ColumnOrderings(column),
  );

  $$DiseasesTableOrderingComposer get diseaseId {
    final $$DiseasesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diseaseId,
      referencedTable: $db.diseases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiseasesTableOrderingComposer(
            $db: $db,
            $table: $db.diseases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableOrderingComposer get medicineId {
    final $$MedicinesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicinesTableOrderingComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreatmentRecommendationsTableAnnotationComposer
    extends Composer<_$ClinicalDatabase, $TreatmentRecommendationsTable> {
  $$TreatmentRecommendationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get dose =>
      $composableBuilder(column: $table.dose, builder: (column) => column);

  GeneratedColumn<String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<String> get duration =>
      $composableBuilder(column: $table.duration, builder: (column) => column);

  GeneratedColumn<String> get normalizedSearchText => $composableBuilder(
    column: $table.normalizedSearchText,
    builder: (column) => column,
  );

  $$DiseasesTableAnnotationComposer get diseaseId {
    final $$DiseasesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.diseaseId,
      referencedTable: $db.diseases,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DiseasesTableAnnotationComposer(
            $db: $db,
            $table: $db.diseases,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MedicinesTableAnnotationComposer get medicineId {
    final $$MedicinesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.medicineId,
      referencedTable: $db.medicines,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MedicinesTableAnnotationComposer(
            $db: $db,
            $table: $db.medicines,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TreatmentRecommendationsTableTableManager
    extends
        RootTableManager<
          _$ClinicalDatabase,
          $TreatmentRecommendationsTable,
          TreatmentRecommendationRow,
          $$TreatmentRecommendationsTableFilterComposer,
          $$TreatmentRecommendationsTableOrderingComposer,
          $$TreatmentRecommendationsTableAnnotationComposer,
          $$TreatmentRecommendationsTableCreateCompanionBuilder,
          $$TreatmentRecommendationsTableUpdateCompanionBuilder,
          (
            TreatmentRecommendationRow,
            $$TreatmentRecommendationsTableReferences,
          ),
          TreatmentRecommendationRow,
          PrefetchHooks Function({bool diseaseId, bool medicineId})
        > {
  $$TreatmentRecommendationsTableTableManager(
    _$ClinicalDatabase db,
    $TreatmentRecommendationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TreatmentRecommendationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$TreatmentRecommendationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$TreatmentRecommendationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> diseaseId = const Value.absent(),
                Value<int> medicineId = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<String> dose = const Value.absent(),
                Value<String> frequency = const Value.absent(),
                Value<String> duration = const Value.absent(),
                Value<String> normalizedSearchText = const Value.absent(),
              }) => TreatmentRecommendationsCompanion(
                id: id,
                diseaseId: diseaseId,
                medicineId: medicineId,
                type: type,
                dose: dose,
                frequency: frequency,
                duration: duration,
                normalizedSearchText: normalizedSearchText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int diseaseId,
                required int medicineId,
                required String type,
                required String dose,
                required String frequency,
                required String duration,
                required String normalizedSearchText,
              }) => TreatmentRecommendationsCompanion.insert(
                id: id,
                diseaseId: diseaseId,
                medicineId: medicineId,
                type: type,
                dose: dose,
                frequency: frequency,
                duration: duration,
                normalizedSearchText: normalizedSearchText,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TreatmentRecommendationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({diseaseId = false, medicineId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (diseaseId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.diseaseId,
                                referencedTable:
                                    $$TreatmentRecommendationsTableReferences
                                        ._diseaseIdTable(db),
                                referencedColumn:
                                    $$TreatmentRecommendationsTableReferences
                                        ._diseaseIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (medicineId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.medicineId,
                                referencedTable:
                                    $$TreatmentRecommendationsTableReferences
                                        ._medicineIdTable(db),
                                referencedColumn:
                                    $$TreatmentRecommendationsTableReferences
                                        ._medicineIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TreatmentRecommendationsTableProcessedTableManager =
    ProcessedTableManager<
      _$ClinicalDatabase,
      $TreatmentRecommendationsTable,
      TreatmentRecommendationRow,
      $$TreatmentRecommendationsTableFilterComposer,
      $$TreatmentRecommendationsTableOrderingComposer,
      $$TreatmentRecommendationsTableAnnotationComposer,
      $$TreatmentRecommendationsTableCreateCompanionBuilder,
      $$TreatmentRecommendationsTableUpdateCompanionBuilder,
      (TreatmentRecommendationRow, $$TreatmentRecommendationsTableReferences),
      TreatmentRecommendationRow,
      PrefetchHooks Function({bool diseaseId, bool medicineId})
    >;
typedef $$SyncMetadataTableCreateCompanionBuilder =
    SyncMetadataCompanion Function({
      required String key,
      required int datasetVersion,
      required DateTime lastSuccessfulSync,
      Value<int> rowid,
    });
typedef $$SyncMetadataTableUpdateCompanionBuilder =
    SyncMetadataCompanion Function({
      Value<String> key,
      Value<int> datasetVersion,
      Value<DateTime> lastSuccessfulSync,
      Value<int> rowid,
    });

class $$SyncMetadataTableFilterComposer
    extends Composer<_$ClinicalDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSuccessfulSync => $composableBuilder(
    column: $table.lastSuccessfulSync,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncMetadataTableOrderingComposer
    extends Composer<_$ClinicalDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSuccessfulSync => $composableBuilder(
    column: $table.lastSuccessfulSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncMetadataTableAnnotationComposer
    extends Composer<_$ClinicalDatabase, $SyncMetadataTable> {
  $$SyncMetadataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<int> get datasetVersion => $composableBuilder(
    column: $table.datasetVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastSuccessfulSync => $composableBuilder(
    column: $table.lastSuccessfulSync,
    builder: (column) => column,
  );
}

class $$SyncMetadataTableTableManager
    extends
        RootTableManager<
          _$ClinicalDatabase,
          $SyncMetadataTable,
          SyncMetadataRow,
          $$SyncMetadataTableFilterComposer,
          $$SyncMetadataTableOrderingComposer,
          $$SyncMetadataTableAnnotationComposer,
          $$SyncMetadataTableCreateCompanionBuilder,
          $$SyncMetadataTableUpdateCompanionBuilder,
          (
            SyncMetadataRow,
            BaseReferences<
              _$ClinicalDatabase,
              $SyncMetadataTable,
              SyncMetadataRow
            >,
          ),
          SyncMetadataRow,
          PrefetchHooks Function()
        > {
  $$SyncMetadataTableTableManager(
    _$ClinicalDatabase db,
    $SyncMetadataTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncMetadataTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncMetadataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncMetadataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<int> datasetVersion = const Value.absent(),
                Value<DateTime> lastSuccessfulSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion(
                key: key,
                datasetVersion: datasetVersion,
                lastSuccessfulSync: lastSuccessfulSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String key,
                required int datasetVersion,
                required DateTime lastSuccessfulSync,
                Value<int> rowid = const Value.absent(),
              }) => SyncMetadataCompanion.insert(
                key: key,
                datasetVersion: datasetVersion,
                lastSuccessfulSync: lastSuccessfulSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncMetadataTableProcessedTableManager =
    ProcessedTableManager<
      _$ClinicalDatabase,
      $SyncMetadataTable,
      SyncMetadataRow,
      $$SyncMetadataTableFilterComposer,
      $$SyncMetadataTableOrderingComposer,
      $$SyncMetadataTableAnnotationComposer,
      $$SyncMetadataTableCreateCompanionBuilder,
      $$SyncMetadataTableUpdateCompanionBuilder,
      (
        SyncMetadataRow,
        BaseReferences<_$ClinicalDatabase, $SyncMetadataTable, SyncMetadataRow>,
      ),
      SyncMetadataRow,
      PrefetchHooks Function()
    >;

class $ClinicalDatabaseManager {
  final _$ClinicalDatabase _db;
  $ClinicalDatabaseManager(this._db);
  $$DiseasesTableTableManager get diseases =>
      $$DiseasesTableTableManager(_db, _db.diseases);
  $$DiseaseKeywordsTableTableManager get diseaseKeywords =>
      $$DiseaseKeywordsTableTableManager(_db, _db.diseaseKeywords);
  $$MedicinesTableTableManager get medicines =>
      $$MedicinesTableTableManager(_db, _db.medicines);
  $$TreatmentRecommendationsTableTableManager get treatmentRecommendations =>
      $$TreatmentRecommendationsTableTableManager(
        _db,
        _db.treatmentRecommendations,
      );
  $$SyncMetadataTableTableManager get syncMetadata =>
      $$SyncMetadataTableTableManager(_db, _db.syncMetadata);
}
