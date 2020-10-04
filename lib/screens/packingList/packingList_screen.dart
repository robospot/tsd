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
        body: BlocConsumer<PackinglistCubit, PackinglistState>(
            listener: (context, state) {
          if (state is PackinglistError) {
            final snackBar = SnackBar(
              content: Text('${state.message}'),
              backgroundColor: Colors.red,
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
        }, builder: (context, state) {
          if (state is PackinglistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PackinglistLoaded) {
            plistController.text = state.packListCode;
            return Container(
                margin: EdgeInsets.only(top: 8, left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Номер упаковочного листа",
                    //   style: Theme.of(context).textTheme.headline6,
                    // ),
                    // SizedBox(
                    //   height: 16,
                    // ),
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
                    Text("Список SSCC"),
                    SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: state.ssccList.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('${state.ssccList[index]}'),
                          );
                        },
                      ),
                    )
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
                ));
          }
        }));
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
