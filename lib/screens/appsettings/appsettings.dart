import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class AppSettings extends StatefulWidget {
  @override
  _AppSettingsState createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SettingsScreen(title: "Настройки", children: [
           SettingsGroup(
   title: 'Настройка длины ШК',
   children: <Widget>[
                   TextInputSettingsTile(
                title: 'Длина кода SSCC',
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
                title: 'Длина кода EAN',
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
                title: 'Длина кода упаковочного листа',
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
   RadioSettingsTile<int>(
  title: 'Язык',
  settingKey: 'language',
  values: <int, String>{
    0: 'Русский',
    1: 'English',
    
  },
  selected: Settings.getValue<int>('language', 0),

  onChange: (value) {
    
  },
)

        ]));
  }
}
