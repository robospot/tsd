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
           
                   TextInputSettingsTile(
                title: 'Длина SSCC',
                settingKey: 'sscc_length',
                initialValue: '10',
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
                title: 'Длина EAN',
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
        ]));
  }
}
