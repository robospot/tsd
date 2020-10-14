import 'package:flutter/material.dart';
import 'package:pda_scanner/pda_source.dart';
import 'package:tsd/screens/appsettings/appsettings.dart';
import 'package:tsd/screens/packingList/cubit/packinglist_cubit.dart';
import 'package:tsd/screens/sscc/cubit/sscc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        title: Text("Список приложений"),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => clickOnSettings(context)),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () => context
                .bloc<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          ),
        ],
      ),
      body: Container(
          margin: EdgeInsets.all(16),
          child: ListView(
            children: [
              ListTile(
                  title: Text(
                    'Комплектование',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onTap: () => Navigator.of(context).pushNamed('/acquisition')),
              Divider(
                color: Colors.grey,
              ),
              ListTile(
                  title: Text('Упаковочный лист',
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
