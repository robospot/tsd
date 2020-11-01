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

class SsccIn extends Table {
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

class SsccOut extends Table {
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

class Packs extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get packCode => text()();
  TextColumn get sscc => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

@UseMoor(
    tables: [Materials, SsccIn, SsccOut, Packs],
    daos: [MaterialDao, SsccInDao, SsccOutDao, PacksDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

//------------------------------------------------------------------------------
@UseDao(tables: [Materials])
class MaterialDao extends DatabaseAccessor<AppDatabase>
    with _$MaterialDaoMixin {
  final AppDatabase db;

  MaterialDao(this.db) : super(db);

  Future insertMaterial(Insertable<Material> m) => into(materials).insert(m);
  Future deleteMaterials() => delete(materials).go();
  Future<Material> getMaterialName(sModel.Sscc sscc, String lang) {
    return (select(materials)
          ..where((m) => m.ean.equals(sscc.ean) & m.language.equals(lang)))
        .getSingle();
  }
}

//------------------------------------------------------------------------------
@UseDao(tables: [SsccIn])
class SsccInDao extends DatabaseAccessor<AppDatabase> with _$SsccInDaoMixin {
  final AppDatabase db;

  SsccInDao(this.db) : super(db);

  Future insertSscc(Insertable<SsccInData> s) => into(ssccIn).insert(s);
  Future<SsccInData> getSsccIn(sModel.Sscc sscc) =>
      (select(ssccIn)..where((s) => s.datamatrix.equals(sscc.datamatrix)))
          .getSingle();

  Future deleteSsccIn() => delete(ssccIn).go();
}

//------------------------------------------------------------------------------
@UseDao(tables: [SsccOut])
class SsccOutDao extends DatabaseAccessor<AppDatabase> with _$SsccOutDaoMixin {
  final AppDatabase db;

  SsccOutDao(this.db) : super(db);

  Future insertSscc(Insertable<SsccOutData> s) async {
    var val = await into(ssccOut).insert(s).catchError((e) {});

//Если DM уже был остканирован - возвращаем ошибку
    if (val == null) throw Exception();
  }

  Future getSsccCount(sModel.Sscc sscc) {
    var ssccCount = ssccOut.datamatrix.count();

    final query = selectOnly(ssccOut)
      ..addColumns([ssccCount])
      ..where(ssccOut.sscc.equals(sscc.sscc))
      ..where(ssccOut.isUsed.equals(true))
      ..groupBy([ssccOut.sscc]);

    var result = query.map((row) => row.read(ssccCount)).getSingle();

    return result;
  }

  Future getEanCount(sModel.Sscc sscc) {
    var eanCount = ssccOut.datamatrix.count();
    final query = selectOnly(ssccOut)
      ..addColumns([eanCount])
      ..where(ssccOut.sscc.equals(sscc.sscc))
      ..where(ssccOut.ean.equals(sscc.ean))
      ..groupBy([ssccOut.sscc]);

    var result = query.map((row) => row.read(eanCount)).getSingle();
    return result;
  }

  Future deleteSsccOut() => delete(ssccOut).go();

  Future<List<SsccOutData>> getSsccOutList() => select(ssccOut).get();
}

//------------------------------------------------------------------------------
@UseDao(tables: [Packs])
class PacksDao extends DatabaseAccessor<AppDatabase> with _$PacksDaoMixin {
  final AppDatabase db;

  PacksDao(this.db) : super(db);
  Future addPack(Insertable<Pack> pack) => into(packs).insert(pack);
  // Future addPackList(Insertable<PackListData> s) => into(packListData.insert(s);
  // Future addPackList(Insertable<PackListData> p) => into(packListData.insert(p);
  // Future<SsccInData> getSsccIn(sModel.Sscc sscc) =>
  //     (select(ssccIn)..where((s) => s.datamatrix.equals(sscc.datamatrix)))
  //         .getSingle();

  // Future deleteSsccIn() => delete(ssccIn).go();
}
