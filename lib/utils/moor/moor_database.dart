import 'package:moor_flutter/moor_flutter.dart';
import 'package:tsd/models/ssccModel.dart';

part 'moor_database.g.dart';

class Materials extends Table {
  IntColumn get id => integer()();
  TextColumn get ean => text()();
  TextColumn get language => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

class Ssccs extends Table {
  IntColumn get organization => integer().nullable()();
  TextColumn get sscc => text().nullable()();
  TextColumn get ean => text()();
  TextColumn get datamatrix => text()();
  BoolColumn get isUsed => boolean()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

@UseMoor(tables: [Materials, Ssccs], daos: [MaterialDao, SsccDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 2;
}

@UseDao(tables: [Materials])
class MaterialDao extends DatabaseAccessor<AppDatabase>
    with _$MaterialDaoMixin {
  final AppDatabase db;

  MaterialDao(this.db) : super(db);

  Future insertMaterial(Insertable<Material> m) => into(materials).insert(m);
}

@UseDao(tables: [Ssccs])
class SsccDao extends DatabaseAccessor<AppDatabase> with _$SsccDaoMixin {
  final AppDatabase db;

  SsccDao(this.db) : super(db);

  Future insertSscc(Insertable<Sscc> s) => into(ssccs).insert(s);
  Future getSsccCount() {
    var countExp = ssccs.isUsed.count();
    final query = selectOnly(ssccs)..addColumns([countExp]);
    var result = query.map((row) => row.read(countExp)).getSingle();
    return result;
  }
}
