import 'package:bloc/bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:meta/meta.dart';
import 'package:tsd/models/sscc.dart';
import 'package:tsd/utils/repository.dart';

part 'sscc_state.dart';

enum CodeType { sscc, ean, dm }

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
    // String ssccCount;
    String eanCount;
    if (state is SsccLoaded) {
      var currentState = state as SsccLoaded;
//Определяем тип отсканированного кода
      CodeType codeType;
      //EAN
      if (scanCode.length ==
          int.parse(Settings.getValue<String>('ean_length', '13'))) {
        codeType = CodeType.ean;
        //Если <=15, то SSCC
      } else if (scanCode.length <= 15) {
        codeType = CodeType.sscc;
      } else
        codeType = CodeType.dm;

      if (codeType == CodeType.sscc) {
        //Показываем EAN, значение в SSCC
        // if (currentState.eanVisibility == false) {
        currentState.eanVisibility = true;
        currentState.eanValue = '';
        currentState.dmValue = '';
        currentState.dmVisibility = false;
        currentState.ssccValue = scanCode;
        currentState.ssccCount = await DataRepository().getSsccCount(scanCode);
      }
      if (codeType == CodeType.ean) {
        //Показываем DM, значение в EAN

        currentState.eanVisibility = true;
        currentState.dmVisibility = true;
        currentState.dmValue = '';
        currentState.eanValue = scanCode;
      }

      if (codeType == CodeType.dm) {
        //Значение в DM

        currentState.dmValue = scanCode;
        //Проверяем что все поля заполнены
        if (currentState.ssccValue != '' &&
            currentState.eanValue != '' &&
            currentState.dmValue != '') {
          try {
            currentState.ssccCount = await DataRepository().addSscc(Sscc(
                sscc: currentState.ssccValue,
                ean: currentState.eanValue,
                datamatrix: currentState.dmValue,
                isUsed: true));
          } catch (e) {
             
            
            print('error!');
            print(e);
            emit(SsccError(message: e.toString()));
          }
        }
      }

      print('ScanCode: $scanCode');
      emit(SsccLoading());
      emit(SsccLoaded(
          dmValue: currentState.dmValue,
          dmVisibility: currentState.dmVisibility,
          eanValue: currentState.eanValue,
          eanVisibility: currentState.eanVisibility,
          ssccValue: currentState.ssccValue,
          ssccCount: currentState.ssccCount));
    }
  }
}
