import 'package:moor_flutter/moor_flutter.dart';

part 'moor_database.g.dart';

class Materials extends Table {
  IntColumn get id => integer()();
  TextColumn get ean => text()();
  TextColumn get language => text()();
  TextColumn get createdAt => text()();
  TextColumn get updatedAt => text()();
}

@UseMoor(tables: [Materials], daos: [MaterialDao])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;
}

@UseDao(tables: [Materials])
class MaterialDao extends DatabaseAccessor<AppDatabase> with _$MaterialDaoMixin {
  final AppDatabase db;

  // Called by the AppDatabase class
  MaterialDao(this.db) : super(db);

  // // All tables have getters in the generated class - we can select the tasks table
  // Future<List<Material>> getAllMaterials() => select(materials).get();

  // // Moor supports Streams which emit elements when the watched data changes
  // Stream<List<Material>> watchAllMaterials() => select(materials).watch();

  Future insertMaterial(Insertable<Material> m) => into(materials).insert(m);

  // // Updates a Task with a matching primary key
  // Future updateMaterial(Material material) =>
  //     update(materials).replace(material);

  // Future deleteMaterial(Material material) =>
  //     delete(materials).delete(material);
}
