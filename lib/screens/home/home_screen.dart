import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:pda_scanner/pda_source.dart';
import 'package:tsd/screens/appsettings/appsettings.dart';
import 'package:tsd/screens/home/cubit/home_cubit.dart';
import 'package:tsd/screens/packingList/cubit/packinglist_cubit.dart';
import 'package:tsd/screens/sscc/cubit/sscc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tsd/utils/authentication/bloc/authentication_bloc.dart';


class HomeScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomeScreen());
  }

  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    PdaSource.init();
    context.bloc<SsccCubit>().initSscc();
    context.bloc<PackinglistCubit>().initPackList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("appBar_AppList".tr()),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => clickOnSettings(context)),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => context
                .bloc<AuthenticationBloc>()
                .add(UserLoggedOut()
            ),
          ),
        ],
      ),
      body: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: [
              SwitchSettingsTile(
                  enabledLabel: "Онлайн",
                  disabledLabel: "Офлайн",
                  defaultValue: true,
                  leading: Icon(Icons.wifi),
                  settingKey: 'isOnline',
                  title: 'Режим работы',
                  onChange: (value) {
                    changeMode(value, context);
                  }),
              ListTile(
                  title: Text(
                    'appList_acquisition'.tr(),
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/acquisition')),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                  title: Text('appList_packing_list'.tr(),
                      style: Theme.of(context).textTheme.bodyText1),
                  onTap: () => Navigator.of(context).pushNamed('/packingList')),
              Divider(
                color: Colors.grey,
              ),
            ],
          )),
    );
  }
}

clickOnSettings(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => AppSettings(),
  ));
}

changeMode(bool value, BuildContext context) {
  context.bloc<HomeCubit>().getOfflineData(value);
}
