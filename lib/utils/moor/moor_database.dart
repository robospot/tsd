import 'package:moor_flutter/moor_flutter.dart';
import 'package:tsd/models/sscc.dart' as sModel;


part 'moor_database.g.dart';

class Materials extends Table {
  IntColumn get id => integer()();
  TextColumn get ean => text()();
  TextColumn get language => text()();
  TextColumn get description => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {id};
}

class Ssccs extends Table {
  IntColumn get organization => integer().nullable()();
  TextColumn get sscc => text().nullable()();
  TextColumn get ean => text()();
  TextColumn get datamatrix => text()();
  BoolColumn get isUsed => boolean().nullable()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();

  @override
  Set<Column> get primaryKey => {datamatrix};
}

@UseMoor(tables: [Materials, Ssccs], daos: [MaterialDao, SsccDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Materials])
class MaterialDao extends DatabaseAccessor<AppDatabase>
    with _$MaterialDaoMixin {
  final AppDatabase db;

  MaterialDao(this.db) : super(db);

  Future insertMaterial(Insertable<Material> m) => into(materials).insert(m);
  Future deleteMaterials() => delete(materials).go();
  Future <Material> getMaterialName(sModel.Sscc sscc, String lang) {
    return (select(materials)
          ..where((m) => m.ean.equals(sscc.ean) & m.language.equals(lang))
          // ..where((l) => l.language.equals(lang)))
    ).getSingle();
  }
}

@UseDao(tables: [Ssccs])
class SsccDao extends DatabaseAccessor<AppDatabase> with _$SsccDaoMixin {
  final AppDatabase db;

  SsccDao(this.db) : super(db);

  Future insertSscc(Insertable<Sscc> s) => into(ssccs).insert(s);

  Future getSsccCount(sModel.Sscc sscc) {
    var ssccCount = ssccs.datamatrix.count();

    final query = selectOnly(ssccs)
      ..addColumns([ssccCount])
      ..where(ssccs.sscc.equals(sscc.sscc))
      ..where(ssccs.isUsed.equals(true))
      ..groupBy([ssccs.sscc]);

    var result = query.map((row) => row.read(ssccCount)).getSingle();

    return result;
  }

  Future getEanCount(sModel.Sscc sscc) {
    var eanCount = ssccs.datamatrix.count();
    final query = selectOnly(ssccs)
      ..addColumns([eanCount])
      ..where(ssccs.sscc.equals(sscc.sscc))
      ..where(ssccs.ean.equals(sscc.ean))
      ..groupBy([ssccs.sscc]);

    var result = query.map((row) => row.read(eanCount)).getSingle();
    return result;
  }

  Future deleteSsccs() => delete(ssccs).go();
}
