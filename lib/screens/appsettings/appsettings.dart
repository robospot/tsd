import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:easy_localization/easy_localization.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SettingsScreen(title: "appBar_Settings".tr(), children: [
      SettingsGroup(title: 'settings_title1'.tr(), children: <Widget>[
        TextInputSettingsTile(
          title: 'settings_sscc_length'.tr(),
          settingKey: 'sscc_length',
          initialValue: '15',
          validator: (String ssccLength) {
            if (ssccLength != null && ssccLength.length != 0) {
              return null;
            }
            return "Поле не может быть пустым";
          },
          borderColor: Colors.blueAccent,
          errorColor: Colors.deepOrangeAccent,
        ),
        TextInputSettingsTile(
          title: 'settings_ean_length'.tr(),
          settingKey: 'ean_length',
          initialValue: '13',
          validator: (String eanLength) {
            if (eanLength != null && eanLength.length != 0) {
              return null;
            }
            return "Поле не может быть пустым";
          },
          borderColor: Colors.blueAccent,
          errorColor: Colors.deepOrangeAccent,
        ),
        TextInputSettingsTile(
          title: 'settings_pl_length'.tr(),
          settingKey: 'packlist_length',
          initialValue: '11',
          validator: (String packlistlength) {
            if (packlistlength != null && packlistlength.length != 0) {
              return null;
            }
            return "Поле не может быть пустым";
          },
          borderColor: Colors.blueAccent,
          errorColor: Colors.deepOrangeAccent,
        ),
      ]),
      RadioSettingsTile<String>(
        title: 'settings_language'.tr(),
        settingKey: 'language',
        values: <String, String>{
          'ru': 'Русский',
          'en': 'English',
        },
        selected: Settings.getValue<String>('language', 'ru'),
        onChange: (value) {
          switch (value) {
            case 'ru':
              context.locale = Locale('ru', 'RU');
              break;
            case 'en':
              context.locale = Locale('en', 'US');
              break;
            default:
              context.locale = Locale('en', 'US');
              break;
          }
        },
      )
    ]));
  }
}
