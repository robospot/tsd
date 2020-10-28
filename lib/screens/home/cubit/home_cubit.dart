import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tsd/utils/moor/moor_database.dart';
import 'package:tsd/utils/repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AppDatabase db;
  final DataRepository dataRepository;
  HomeCubit(
    this.dataRepository,
    this.db,
  ) : super(HomeInitial());

  Future<void> getOfflineData(bool isOnline) async {
    
    print('Режим работы приложения: $isOnline');
    if (isOnline) {
       print('Переходим в Онлайн режим, очищаем локальные данные');
      removeMaterials(db.materialDao);
      removeSscc(db.ssccDao);
     
    } else {
      print('Переходим в Офлайн режим, забираем данные с сервера');
      List<Material> materialList = await dataRepository.getMaterials();
      List<Sscc> ssccList = await dataRepository.getSsccc();
      await insertMaterials(materialList, db.materialDao);
      await insertSscc(ssccList, db.ssccDao);
    }
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

Future<void> removeMaterials(MaterialDao db) async {
  db.deleteMaterials();
}

Future<void> insertSscc(List<Sscc> ssccList, SsccDao db) async {
  ssccList.forEach((s) {
    final sscc = SsccsCompanion(
        sscc: Value(s.sscc),
        ean: Value(s.ean),
        isUsed: Value(s.isUsed),
        datamatrix: Value(s.datamatrix),
        createdAt: Value(s.createdAt),
        updatedAt: Value(s.updatedAt));

    db.insertSscc(sscc);
  });
}

Future<void> removeSscc(SsccDao db) async {
  db.deleteSsccs();
}
