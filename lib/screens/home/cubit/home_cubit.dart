import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tsd/utils/moor/moor_database.dart';
import 'package:tsd/utils/repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final MaterialDao db;
  HomeCubit(this.db) : super(HomeInitial());

  Future<void> getOfflineData() async {
    List<Material> materialList = await DataRepository().getMaterials();
    await insertMaterials(materialList, db);
  }
}

Future<void> insertMaterials(List<Material> materials, MaterialDao db) async {
  // await batch((batch) {
  // functions in a batch don't have to be awaited - just
  // await the whole batch afterwards.
  // batch.insertAll(materials, [
  //   MaterialsCompanion.insert(

  //   ),

  // ]);
  // });

  materials.forEach((m) {
    final mat = MaterialsCompanion(
        ean: Value(m.ean),
        language: Value(m.language),
        createdAt: Value(m.createdAt),
        updatedAt: Value(m.updatedAt),
        id: Value(m.id));
    db.insertMaterial(mat);
  });
}
