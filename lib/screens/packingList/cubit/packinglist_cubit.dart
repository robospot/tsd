import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

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
          break;
        case CodeType.sscc:
          currentState.sscc = scanCode;
          if (currentState.ssccList.contains(scanCode)) {
            currentState.ssccList.remove(scanCode);
          } else {
            currentState.ssccList.add(scanCode);
          }
          break;

        default:
          currentState.ssccList.add(scanCode);
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
