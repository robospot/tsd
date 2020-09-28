import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd/models/sscc.dart';
import 'package:tsd/utils/repository.dart';

part 'sscc_state.dart';

class SsccCubit extends Cubit<SsccState> {
  SsccCubit() : super(SsccInitial());

  Future<void> initSscc() async {
    String ssccValue = '';
    String eanValue = '';
    String dmValue = '';
    bool eanVisibility = false;
    bool dmVisibility = false;
    emit(SsccLoading());
    emit(SsccLoaded(
        ssccValue: ssccValue,
        eanValue: eanValue,
        dmValue: dmValue,
        eanVisibility: eanVisibility,
        dmVisibility: dmVisibility));
  }

  Future<void> scanSscc(String scanCode) async {
    if (state is SsccLoaded) {
      var currentState = state as SsccLoaded;
      //Показываем EAN, значение в SSCC
      if (currentState.eanVisibility == false) {
        currentState.eanVisibility = true;
        currentState.ssccValue = scanCode;
        String ssccCount = await DataRepository().getSsccCount(scanCode);
        print(ssccCount);
      } else if (currentState.dmVisibility == false) {
        //Показываем DM, значение в EAN
        currentState.dmVisibility = true;
        currentState.eanValue = scanCode;
      } else
      // Значение в DM
      {
        currentState.dmValue = scanCode;
        await DataRepository().addSscc(Sscc(
            sscc: currentState.ssccValue,
            ean: currentState.eanValue,
            datamatrix: currentState.dmValue,
            isUsed: true));
      }
      print('ScanCode: $scanCode');
      emit(SsccLoading());
      emit(SsccLoaded(
          dmValue: currentState.dmValue,
          dmVisibility: currentState.dmVisibility,
          eanValue: currentState.eanValue,
          eanVisibility: currentState.eanVisibility,
          ssccValue: currentState.ssccValue));
    }
  }
}
