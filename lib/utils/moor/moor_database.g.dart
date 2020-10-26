// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Material extends DataClass implements Insertable<Material> {
  final int id;
  final String ean;
  final String language;
  final String createdAt;
  final String updatedAt;
  Material(
      {@required this.id,
      @required this.ean,
      @required this.language,
      @required this.createdAt,
      @required this.updatedAt});
  factory Material.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return Material(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      ean: stringType.mapFromDatabaseResponse(data['${effectivePrefix}ean']),
      language: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}language']),
      createdAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int>(id);
    }
    if (!nullToAbsent || ean != null) {
      map['ean'] = Variable<String>(ean);
    }
    if (!nullToAbsent || language != null) {
      map['language'] = Variable<String>(language);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  MaterialsCompanion toCompanion(bool nullToAbsent) {
    return MaterialsCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      ean: ean == null && nullToAbsent ? const Value.absent() : Value(ean),
      language: language == null && nullToAbsent
          ? const Value.absent()
          : Value(language),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Material.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Material(
      id: serializer.fromJson<int>(json['id']),
      ean: serializer.fromJson<String>(json['ean']),
      language: serializer.fromJson<String>(json['language']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ean': serializer.toJson<String>(ean),
      'language': serializer.toJson<String>(language),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Material copyWith(
          {int id,
          String ean,
          String language,
          String createdAt,
          String updatedAt}) =>
      Material(
        id: id ?? this.id,
        ean: ean ?? this.ean,
        language: language ?? this.language,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Material(')
          ..write('id: $id, ')
          ..write('ean: $ean, ')
          ..write('language: $language, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          ean.hashCode,
          $mrjc(language.hashCode,
              $mrjc(createdAt.hashCode, updatedAt.hashCode)))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Material &&
          other.id == this.id &&
          other.ean == this.ean &&
          other.language == this.language &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MaterialsCompanion extends UpdateCompanion<Material> {
  final Value<int> id;
  final Value<String> ean;
  final Value<String> language;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const MaterialsCompanion({
    this.id = const Value.absent(),
    this.ean = const Value.absent(),
    this.language = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MaterialsCompanion.insert({
    @required int id,
    @required String ean,
    @required String language,
    @required String createdAt,
    @required String updatedAt,
  })  : id = Value(id),
        ean = Value(ean),
        language = Value(language),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Material> custom({
    Expression<int> id,
    Expression<String> ean,
    Expression<String> language,
    Expression<String> createdAt,
    Expression<String> updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ean != null) 'ean': ean,
      if (language != null) 'language': language,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MaterialsCompanion copyWith(
      {Value<int> id,
      Value<String> ean,
      Value<String> language,
      Value<String> createdAt,
      Value<String> updatedAt}) {
    return MaterialsCompanion(
      id: id ?? this.id,
      ean: ean ?? this.ean,
      language: language ?? this.language,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ean.present) {
      map['ean'] = Variable<String>(ean.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaterialsCompanion(')
          ..write('id: $id, ')
          ..write('ean: $ean, ')
          ..write('language: $language, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MaterialsTable extends Materials
    with TableInfo<$MaterialsTable, Material> {
  final GeneratedDatabase _db;
  final String _alias;
  $MaterialsTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn(
      'id',
      $tableName,
      false,
    );
  }

  final VerificationMeta _eanMeta = const VerificationMeta('ean');
  GeneratedTextColumn _ean;
  @override
  GeneratedTextColumn get ean => _ean ??= _constructEan();
  GeneratedTextColumn _constructEan() {
    return GeneratedTextColumn(
      'ean',
      $tableName,
      false,
    );
  }

  final VerificationMeta _languageMeta = const VerificationMeta('language');
  GeneratedTextColumn _language;
  @override
  GeneratedTextColumn get language => _language ??= _constructLanguage();
  GeneratedTextColumn _constructLanguage() {
    return GeneratedTextColumn(
      'language',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedTextColumn _createdAt;
  @override
  GeneratedTextColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedTextColumn _constructCreatedAt() {
    return GeneratedTextColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedTextColumn _updatedAt;
  @override
  GeneratedTextColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedTextColumn _constructUpdatedAt() {
    return GeneratedTextColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [id, ean, language, createdAt, updatedAt];
  @override
  $MaterialsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'materials';
  @override
  final String actualTableName = 'materials';
  @override
  VerificationContext validateIntegrity(Insertable<Material> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id'], _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('ean')) {
      context.handle(
          _eanMeta, ean.isAcceptableOrUnknown(data['ean'], _eanMeta));
    } else if (isInserting) {
      context.missing(_eanMeta);
    }
    if (data.containsKey('language')) {
      context.handle(_languageMeta,
          language.isAcceptableOrUnknown(data['language'], _languageMeta));
    } else if (isInserting) {
      context.missing(_languageMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at'], _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Material map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Material.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $MaterialsTable createAlias(String alias) {
    return $MaterialsTable(_db, alias);
  }
}

class Sscc extends DataClass implements Insertable<Sscc> {
  final int organization;
  final String sscc;
  final String ean;
  final String datamatrix;
  final bool isUsed;
  final String createdAt;
  final String updatedAt;
  Sscc(
      {this.organization,
      this.sscc,
      @required this.ean,
      @required this.datamatrix,
      @required this.isUsed,
      @required this.createdAt,
      @required this.updatedAt});
  factory Sscc.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    final boolType = db.typeSystem.forDartType<bool>();
    return Sscc(
      organization: intType
          .mapFromDatabaseResponse(data['${effectivePrefix}organization']),
      sscc: stringType.mapFromDatabaseResponse(data['${effectivePrefix}sscc']),
      ean: stringType.mapFromDatabaseResponse(data['${effectivePrefix}ean']),
      datamatrix: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}datamatrix']),
      isUsed:
          boolType.mapFromDatabaseResponse(data['${effectivePrefix}is_used']),
      createdAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}created_at']),
      updatedAt: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}updated_at']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || organization != null) {
      map['organization'] = Variable<int>(organization);
    }
    if (!nullToAbsent || sscc != null) {
      map['sscc'] = Variable<String>(sscc);
    }
    if (!nullToAbsent || ean != null) {
      map['ean'] = Variable<String>(ean);
    }
    if (!nullToAbsent || datamatrix != null) {
      map['datamatrix'] = Variable<String>(datamatrix);
    }
    if (!nullToAbsent || isUsed != null) {
      map['is_used'] = Variable<bool>(isUsed);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<String>(createdAt);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<String>(updatedAt);
    }
    return map;
  }

  SsccsCompanion toCompanion(bool nullToAbsent) {
    return SsccsCompanion(
      organization: organization == null && nullToAbsent
          ? const Value.absent()
          : Value(organization),
      sscc: sscc == null && nullToAbsent ? const Value.absent() : Value(sscc),
      ean: ean == null && nullToAbsent ? const Value.absent() : Value(ean),
      datamatrix: datamatrix == null && nullToAbsent
          ? const Value.absent()
          : Value(datamatrix),
      isUsed:
          isUsed == null && nullToAbsent ? const Value.absent() : Value(isUsed),
      createdAt: createdAt == null && nullToAbsent
          ? const Value.absent()
          : Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory Sscc.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Sscc(
      organization: serializer.fromJson<int>(json['organization']),
      sscc: serializer.fromJson<String>(json['sscc']),
      ean: serializer.fromJson<String>(json['ean']),
      datamatrix: serializer.fromJson<String>(json['datamatrix']),
      isUsed: serializer.fromJson<bool>(json['isUsed']),
      createdAt: serializer.fromJson<String>(json['createdAt']),
      updatedAt: serializer.fromJson<String>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'organization': serializer.toJson<int>(organization),
      'sscc': serializer.toJson<String>(sscc),
      'ean': serializer.toJson<String>(ean),
      'datamatrix': serializer.toJson<String>(datamatrix),
      'isUsed': serializer.toJson<bool>(isUsed),
      'createdAt': serializer.toJson<String>(createdAt),
      'updatedAt': serializer.toJson<String>(updatedAt),
    };
  }

  Sscc copyWith(
          {int organization,
          String sscc,
          String ean,
          String datamatrix,
          bool isUsed,
          String createdAt,
          String updatedAt}) =>
      Sscc(
        organization: organization ?? this.organization,
        sscc: sscc ?? this.sscc,
        ean: ean ?? this.ean,
        datamatrix: datamatrix ?? this.datamatrix,
        isUsed: isUsed ?? this.isUsed,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  @override
  String toString() {
    return (StringBuffer('Sscc(')
          ..write('organization: $organization, ')
          ..write('sscc: $sscc, ')
          ..write('ean: $ean, ')
          ..write('datamatrix: $datamatrix, ')
          ..write('isUsed: $isUsed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      organization.hashCode,
      $mrjc(
          sscc.hashCode,
          $mrjc(
              ean.hashCode,
              $mrjc(
                  datamatrix.hashCode,
                  $mrjc(isUsed.hashCode,
                      $mrjc(createdAt.hashCode, updatedAt.hashCode)))))));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Sscc &&
          other.organization == this.organization &&
          other.sscc == this.sscc &&
          other.ean == this.ean &&
          other.datamatrix == this.datamatrix &&
          other.isUsed == this.isUsed &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class SsccsCompanion extends UpdateCompanion<Sscc> {
  final Value<int> organization;
  final Value<String> sscc;
  final Value<String> ean;
  final Value<String> datamatrix;
  final Value<bool> isUsed;
  final Value<String> createdAt;
  final Value<String> updatedAt;
  const SsccsCompanion({
    this.organization = const Value.absent(),
    this.sscc = const Value.absent(),
    this.ean = const Value.absent(),
    this.datamatrix = const Value.absent(),
    this.isUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  SsccsCompanion.insert({
    this.organization = const Value.absent(),
    this.sscc = const Value.absent(),
    @required String ean,
    @required String datamatrix,
    @required bool isUsed,
    @required String createdAt,
    @required String updatedAt,
  })  : ean = Value(ean),
        datamatrix = Value(datamatrix),
        isUsed = Value(isUsed),
        createdAt = Value(createdAt),
        updatedAt = Value(updatedAt);
  static Insertable<Sscc> custom({
    Expression<int> organization,
    Expression<String> sscc,
    Expression<String> ean,
    Expression<String> datamatrix,
    Expression<bool> isUsed,
    Expression<String> createdAt,
    Expression<String> updatedAt,
  }) {
    return RawValuesInsertable({
      if (organization != null) 'organization': organization,
      if (sscc != null) 'sscc': sscc,
      if (ean != null) 'ean': ean,
      if (datamatrix != null) 'datamatrix': datamatrix,
      if (isUsed != null) 'is_used': isUsed,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  SsccsCompanion copyWith(
      {Value<int> organization,
      Value<String> sscc,
      Value<String> ean,
      Value<String> datamatrix,
      Value<bool> isUsed,
      Value<String> createdAt,
      Value<String> updatedAt}) {
    return SsccsCompanion(
      organization: organization ?? this.organization,
      sscc: sscc ?? this.sscc,
      ean: ean ?? this.ean,
      datamatrix: datamatrix ?? this.datamatrix,
      isUsed: isUsed ?? this.isUsed,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (organization.present) {
      map['organization'] = Variable<int>(organization.value);
    }
    if (sscc.present) {
      map['sscc'] = Variable<String>(sscc.value);
    }
    if (ean.present) {
      map['ean'] = Variable<String>(ean.value);
    }
    if (datamatrix.present) {
      map['datamatrix'] = Variable<String>(datamatrix.value);
    }
    if (isUsed.present) {
      map['is_used'] = Variable<bool>(isUsed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<String>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<String>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SsccsCompanion(')
          ..write('organization: $organization, ')
          ..write('sscc: $sscc, ')
          ..write('ean: $ean, ')
          ..write('datamatrix: $datamatrix, ')
          ..write('isUsed: $isUsed, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $SsccsTable extends Ssccs with TableInfo<$SsccsTable, Sscc> {
  final GeneratedDatabase _db;
  final String _alias;
  $SsccsTable(this._db, [this._alias]);
  final VerificationMeta _organizationMeta =
      const VerificationMeta('organization');
  GeneratedIntColumn _organization;
  @override
  GeneratedIntColumn get organization =>
      _organization ??= _constructOrganization();
  GeneratedIntColumn _constructOrganization() {
    return GeneratedIntColumn(
      'organization',
      $tableName,
      true,
    );
  }

  final VerificationMeta _ssccMeta = const VerificationMeta('sscc');
  GeneratedTextColumn _sscc;
  @override
  GeneratedTextColumn get sscc => _sscc ??= _constructSscc();
  GeneratedTextColumn _constructSscc() {
    return GeneratedTextColumn(
      'sscc',
      $tableName,
      true,
    );
  }

  final VerificationMeta _eanMeta = const VerificationMeta('ean');
  GeneratedTextColumn _ean;
  @override
  GeneratedTextColumn get ean => _ean ??= _constructEan();
  GeneratedTextColumn _constructEan() {
    return GeneratedTextColumn(
      'ean',
      $tableName,
      false,
    );
  }

  final VerificationMeta _datamatrixMeta = const VerificationMeta('datamatrix');
  GeneratedTextColumn _datamatrix;
  @override
  GeneratedTextColumn get datamatrix => _datamatrix ??= _constructDatamatrix();
  GeneratedTextColumn _constructDatamatrix() {
    return GeneratedTextColumn(
      'datamatrix',
      $tableName,
      false,
    );
  }

  final VerificationMeta _isUsedMeta = const VerificationMeta('isUsed');
  GeneratedBoolColumn _isUsed;
  @override
  GeneratedBoolColumn get isUsed => _isUsed ??= _constructIsUsed();
  GeneratedBoolColumn _constructIsUsed() {
    return GeneratedBoolColumn(
      'is_used',
      $tableName,
      false,
    );
  }

  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  GeneratedTextColumn _createdAt;
  @override
  GeneratedTextColumn get createdAt => _createdAt ??= _constructCreatedAt();
  GeneratedTextColumn _constructCreatedAt() {
    return GeneratedTextColumn(
      'created_at',
      $tableName,
      false,
    );
  }

  final VerificationMeta _updatedAtMeta = const VerificationMeta('updatedAt');
  GeneratedTextColumn _updatedAt;
  @override
  GeneratedTextColumn get updatedAt => _updatedAt ??= _constructUpdatedAt();
  GeneratedTextColumn _constructUpdatedAt() {
    return GeneratedTextColumn(
      'updated_at',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns =>
      [organization, sscc, ean, datamatrix, isUsed, createdAt, updatedAt];
  @override
  $SsccsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'ssccs';
  @override
  final String actualTableName = 'ssccs';
  @override
  VerificationContext validateIntegrity(Insertable<Sscc> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('organization')) {
      context.handle(
          _organizationMeta,
          organization.isAcceptableOrUnknown(
              data['organization'], _organizationMeta));
    }
    if (data.containsKey('sscc')) {
      context.handle(
          _ssccMeta, sscc.isAcceptableOrUnknown(data['sscc'], _ssccMeta));
    }
    if (data.containsKey('ean')) {
      context.handle(
          _eanMeta, ean.isAcceptableOrUnknown(data['ean'], _eanMeta));
    } else if (isInserting) {
      context.missing(_eanMeta);
    }
    if (data.containsKey('datamatrix')) {
      context.handle(
          _datamatrixMeta,
          datamatrix.isAcceptableOrUnknown(
              data['datamatrix'], _datamatrixMeta));
    } else if (isInserting) {
      context.missing(_datamatrixMeta);
    }
    if (data.containsKey('is_used')) {
      context.handle(_isUsedMeta,
          isUsed.isAcceptableOrUnknown(data['is_used'], _isUsedMeta));
    } else if (isInserting) {
      context.missing(_isUsedMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at'], _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at'], _updatedAtMeta));
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => <GeneratedColumn>{};
  @override
  Sscc map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Sscc.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $SsccsTable createAlias(String alias) {
    return $SsccsTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $MaterialsTable _materials;
  $MaterialsTable get materials => _materials ??= $MaterialsTable(this);
  $SsccsTable _ssccs;
  $SsccsTable get ssccs => _ssccs ??= $SsccsTable(this);
  MaterialDao _materialDao;
  MaterialDao get materialDao =>
      _materialDao ??= MaterialDao(this as AppDatabase);
  SsccDao _ssccDao;
  SsccDao get ssccDao => _ssccDao ??= SsccDao(this as AppDatabase);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [materials, ssccs];
}

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$MaterialDaoMixin on DatabaseAccessor<AppDatabase> {
  $MaterialsTable get materials => attachedDatabase.materials;
}
mixin _$SsccDaoMixin on DatabaseAccessor<AppDatabase> {
  $SsccsTable get ssccs => attachedDatabase.ssccs;
}
