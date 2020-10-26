import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tsd/utils/moor/moor_database.dart';
import 'package:tsd/utils/repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppDatabase db;
  final DataRepository dataRepository;
  HomeCubit( this.dataRepository, this.db,) : super(HomeInitial());

  Future<void> getOfflineData() async {
    List<Material> materialList = await dataRepository.getMaterials();
    List<Sscc> ssccList = await dataRepository.getSsccc();
    await insertMaterials(materialList, db.materialDao);
    await insertSscc(ssccList, db.ssccDao);
  }
}

Future<void> insertMaterials(List<Material> materials, MaterialDao db) async {
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

Future<void> insertSscc(List<Sscc> ssccList, SsccDao db) async {
  ssccList.forEach((s) {
    final sscc = SsccsCompanion(
        sscc: Value(s.sscc),
        ean: Value(s.ean),
        datamatrix: Value(s.datamatrix),
        createdAt: Value(s.createdAt),
        updatedAt: Value(s.updatedAt));

    db.insertSscc(sscc);
  });
}
