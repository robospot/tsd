import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsd/models/sscc.dart';
import 'package:tsd/models/ssccModel.dart';
import 'package:tsd/utils/repository.dart';
import 'package:easy_localization/easy_localization.dart';

part 'sscc_state.dart';

enum CodeType { sscc, ean, dm, packList }

class SsccCubit extends Cubit<SsccState> {
  SsccCubit() : super(SsccInitial());

  Future<void> initSscc() async {
    String ssccValue = '';
    String eanValue = '';
    String dmValue = '';
    String eanDescription = 'acquisition_position_name'.tr();
    bool eanVisibility = false;
    bool dmVisibility = false;
    int ssccCount = 0;
    int eanCount = 0;
    emit(SsccLoading());
    emit(SsccLoaded(
        ssccValue: ssccValue,
        eanValue: eanValue,
        dmValue: dmValue,
        eanVisibility: eanVisibility,
        dmVisibility: dmVisibility,
        ssccCount: ssccCount,
        eanCount: eanCount,
        eanDescription: eanDescription));
  }

  Future<void> scanSscc(String scanCode) async {
    // String ssccCount;
    // String eanCount;
    SsccModel ssccModel = SsccModel();
    if (state is SsccLoaded) {
      var currentState = state as SsccLoaded;
//Определяем тип отсканированного кода

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
        case CodeType.sscc:
          //Показываем EAN, значение в SSCC

          currentState.eanVisibility = true;
          currentState.eanValue = '';
          currentState.dmValue = '';
          currentState.dmVisibility = false;
          currentState.ssccValue = scanCode;

          //Очищаем имя EAN
          currentState.eanDescription = 'acquisition_position_name'.tr();
//Подсчет кол-ва КМ в SSCC
          ssccModel = await DataRepository().getSsccCount(scanCode);
          currentState.ssccCount = ssccModel.ssccCount;
          currentState.eanCount = 0;
          break;
        case CodeType.ean:
          //Проверяем что SSCC заполнено
          if (currentState.ssccValue != '') {
            //Показываем DM, значение в EAN

            currentState.eanVisibility = true;
            currentState.dmVisibility = true;
            currentState.dmValue = '';
            currentState.eanValue = scanCode;
//передаем SSCC и EAN чтобы посчитать кол-во позиций
            ssccModel = await DataRepository().getEanCount(currentState.ssccValue, currentState.eanValue);

            currentState.eanCount = ssccModel.eanCount;
            currentState.eanDescription =
                ssccModel.eanDescription ?? 'acquisition_position_name'.tr();
          }
          break;

        case CodeType.dm:
          //Значение в DM

          currentState.dmValue = scanCode;
          //Проверяем что все поля заполнены
          if (currentState.ssccValue != '' &&
              currentState.eanValue != '' &&
              currentState.dmValue != '') {
            try {
              ssccModel = await DataRepository().addSscc(Sscc(
                  sscc: currentState.ssccValue,
                  ean: currentState.eanValue,
                  datamatrix: currentState.dmValue,
                  isUsed: true));
              currentState.ssccCount = ssccModel.ssccCount;
              currentState.eanCount = ssccModel.eanCount;
            } catch (e) {
              print('error!');
              print(e);
              emit(SsccError(message: e.toString()));
            }
          }
          break;

        default:
          break;
      }

//       if (codeType == CodeType.sscc) {
//         //Показываем EAN, значение в SSCC
//         // if (currentState.eanVisibility == false) {
//         currentState.eanVisibility = true;
//         currentState.eanValue = '';
//         currentState.dmValue = '';
//         currentState.dmVisibility = false;
//         currentState.ssccValue = scanCode;

// //Подсчет кол-ва КМ в SSCC
//         ssccModel = await DataRepository().getSsccCount(scanCode);
//         currentState.ssccCount = ssccModel.ssccCount;
//         currentState.eanCount = 0;
//       }
//       if (codeType == CodeType.ean) {
//         //Показываем DM, значение в EAN

//         currentState.eanVisibility = true;
//         currentState.dmVisibility = true;
//         currentState.dmValue = '';
//         currentState.eanValue = scanCode;

//         ssccModel = await DataRepository().getEanCount(scanCode);
//         // print(ssccModel.toString());
//         currentState.eanCount = ssccModel.eanCount;
//         currentState.eanDescription =
//             ssccModel.eanDescription ?? 'Название позиции';
//         // print(currentState.eanDescription);
//       }

//       if (codeType == CodeType.dm) {
//         //Значение в DM

//         currentState.dmValue = scanCode;
//         //Проверяем что все поля заполнены
//         if (currentState.ssccValue != '' &&
//             currentState.eanValue != '' &&
//             currentState.dmValue != '') {
//           try {
//             ssccModel = await DataRepository().addSscc(Sscc(
//                 sscc: currentState.ssccValue,
//                 ean: currentState.eanValue,
//                 datamatrix: currentState.dmValue,
//                 isUsed: true));
//             currentState.ssccCount = ssccModel.ssccCount;
//             currentState.eanCount = ssccModel.eanCount;
//           } catch (e) {
//             print('error!');
//             print(e);
//             emit(SsccError(message: e.toString()));
//           }
//         }
//       }

//Передаем полученную структуру
      print('ScanCode: $scanCode');
      emit(SsccLoading());
      emit(SsccLoaded(
          dmValue: currentState.dmValue,
          dmVisibility: currentState.dmVisibility,
          eanValue: currentState.eanValue,
          eanVisibility: currentState.eanVisibility,
          ssccValue: currentState.ssccValue,
          ssccCount: currentState.ssccCount,
          eanCount: currentState.eanCount,
          eanDescription: currentState.eanDescription));
    }
  }
}
