import 'package:flutter/material.dart';
import 'package:pda_scanner/pda_source.dart';

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
   
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Список приложений"),),
          body: Container(margin: EdgeInsets.all(16),
         child: ListView(children: [
           ListTile(title: Text('Комплектование'),onTap: ()=>  Navigator.of(context).pushNamed('/acquisition')),
           ListTile(title: Text('Упаковочный лист'),onTap: ()=>  Navigator.of(context).pushNamed('/packingList')),

         ],)
      ),
    );
  }
}