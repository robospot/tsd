import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd/models/packList.dart';
import 'package:tsd/utils/repository.dart';

part 'packinglist_state.dart';

enum CodeType { packList, sscc, ean, dm }

class PackinglistCubit extends Cubit<PackinglistState> {
  PackinglistCubit() : super(PackinglistInitial());
  Future<void> scanPack(String scanCode) async {
    if (state is PackinglistLoaded) {
      var currentState = state as PackinglistLoaded;

      CodeType codeType;
      switch (scanCode.length) {
        case 13:
          codeType = CodeType.ean;
          break;
        case 15:
          codeType = CodeType.sscc;
          break;
        case 11:
          codeType = CodeType.packList;
          break;
        default:
          codeType = CodeType.dm;
          break;
      }

      switch (codeType) {
        case CodeType.packList:
          currentState.packListCode = scanCode;
          List<String> plList =
              await DataRepository().getPackListById(scanCode);
          // print(plList);
          currentState.ssccList = plList;
          break;
        case CodeType.sscc:
          currentState.sscc = scanCode;
          if (currentState.ssccList.contains(scanCode)) {
            currentState.ssccList.remove(scanCode);
            await DataRepository().addPackList(PackList(
                sscc: currentState.sscc, packList: currentState.packListCode));
          } else {
            try {
              await DataRepository().addPackList(PackList(
                  sscc: currentState.sscc,
                  packList: currentState.packListCode));
              currentState.ssccList.add(scanCode);
            } catch(e) {
              print('error: $e');
              emit(PackinglistError(message: e.toString()));
            }
          }
          break;

        default:
          // currentState.ssccList.add(scanCode);
          break;
      }

      emit(PackinglistLoading());

      emit(PackinglistLoaded(
          sscc: currentState.sscc,
          packListCode: currentState.packListCode,
          ssccList: currentState.ssccList));
    }
  }

  Future<void> initPackList() async {
    emit(PackinglistLoading());
    List<String> ssccList = List<String>();
    emit(PackinglistLoaded(sscc: '', packListCode: '', ssccList: ssccList));
  }
}
