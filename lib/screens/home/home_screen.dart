import 'package:flutter/material.dart';
import 'package:pda_scanner/pda_source.dart';
import 'package:tsd/screens/appsettings/appsettings.dart';
import 'package:tsd/screens/packingList/cubit/packinglist_cubit.dart';
import 'package:tsd/screens/sscc/cubit/sscc_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
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
    return Scaffold(appBar: AppBar(title: Text("Список приложений"), actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => clickOnSettings(context)
              )
        ],),
          body: Container(margin: EdgeInsets.all(16),
         child: ListView(children: [
           ListTile(title: Text('Комплектование'),onTap: ()=>  Navigator.of(context).pushNamed('/acquisition')),
           ListTile(title: Text('Упаковочный лист'),onTap: ()=>  Navigator.of(context).pushNamed('/packingList')),

         ],)
      ),
    );
  }
}

clickOnSettings(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => AppSettings(),
  ));
}