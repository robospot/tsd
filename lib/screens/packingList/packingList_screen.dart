import 'package:flutter/material.dart';
import 'package:pda_scanner/pda_listener_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/packinglist_cubit.dart';

class PackingListScreen extends StatefulWidget {
  PackingListScreen({Key key}) : super(key: key);

  @override
  _PackingListScreenState createState() => _PackingListScreenState();
}

class _PackingListScreenState extends State<PackingListScreen>
 with PdaListenerMixin<PackingListScreen> {
  TextEditingController plistController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Упаковочный лист"),
        ),
        body: Container(
            child: Column(
          children: [
            Text(
              "Номер упаковочного листа",
              style: Theme.of(context).textTheme.headline4,
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              enabled: false,
              controller: plistController,
              decoration: InputDecoration(
                labelText: 'Номер упаковочного листа',
                // suffixIcon: IconButton(
                //   icon: Icon(
                //     Icons.clear,
                //     color: Color(0xff3678AF),
                //   ),
                //   onPressed: () => sscccontroller.clear(),
                // )
              ),
            ),
            SizedBox(
              height: 16,
            ),
            // Container(
            //   // color: Color(0xffE3F2FF),
            //   height: 80,
            //   child: Center(
            //       child: Container(
            //     margin: EdgeInsets.all(16),
            //     child: SizedBox.expand(
            //         child: RaisedButton(
            //       child: Text('Создать'),
            //     )),
            //   )),
            // )
          ],
        )));
  }

 @override
  void onEvent(Object event) {
    String scanCode = event;
    context.bloc<PackinglistCubit>().scanPack(scanCode);
  }

  @override
  void onError(Object error) {
    /// TODO: implement onError
  }
}
