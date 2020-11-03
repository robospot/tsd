import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:moor_flutter/moor_flutter.dart';
import 'package:tsd/models/packList.dart';
import 'package:tsd/models/sscc.dart';
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

//--------------------------------------------------------------------
//Передаем данные на сервер
//--------------------------------------------------------------------
      List<SsccOutData> ssccOutList = await db.ssccOutDao.getSsccOutList();

      // Передаем данные по SSCC
      ssccOutList.forEach((s) {
        try {
          Sscc ssccOut =
              Sscc(sscc: s.sscc, ean: s.ean, datamatrix: s.datamatrix);
          dataRepository.addSscc(ssccOut, isOnline);
        } catch (e) {}
      });

      List<Pack> packs = await db.packsDao.getPackList();

      packs.forEach((p) {
        try {
          PackList pl = PackList(packList: p.packCode, sscc: p.sscc);
          dataRepository.addPackList(pl, isOnline);
        } catch (e) {}
      });

      removeMaterials(db.materialDao);
      removeSsccIn(db.ssccInDao);
      removeSsccOut(db.ssccOutDao);
      removePacks(db.packsDao);
    } else {
      print('Переходим в Офлайн режим, забираем данные с сервера');
      List<Material> materialList = await dataRepository.getMaterials();
      List<SsccInData> ssccList = await dataRepository.getSsccc();
      await insertMaterials(materialList, db.materialDao);
      await insertSscc(ssccList, db.ssccInDao);
    }
  }
}

Future<void> insertMaterials(List<Material> materials, MaterialDao db) async {
  materials.forEach((m) {
    final mat = MaterialsCompanion(
        ean: Value(m.ean),
        language: Value(m.language),
        description: Value(m.description),
        createdAt: Value(m.createdAt),
        updatedAt: Value(m.updatedAt),
        id: Value(m.id));
    db.insertMaterial(mat);
  });
}

Future<void> insertSscc(List<SsccInData> ssccList, SsccInDao db) async {
  ssccList.forEach((s) {
    final sscc = SsccInCompanion(
        sscc: Value(s.sscc),
        ean: Value(s.ean),
        isUsed: Value(s.isUsed),
        datamatrix: Value(s.datamatrix),
        createdAt: Value(s.createdAt),
        updatedAt: Value(s.updatedAt));

    db.insertSscc(sscc);
  });
}

Future<void> removeMaterials(MaterialDao db) async {
  await db.deleteMaterials();
}

Future<void> removeSsccIn(SsccInDao db) async {
  await db.deleteSsccIn();
}

Future<void> removeSsccOut(SsccOutDao db) async {
  await db.deleteSsccOut();
}

Future<void> removePacks(PacksDao db) async {
  await db.removePacks();
}
