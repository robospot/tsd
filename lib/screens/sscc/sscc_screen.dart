import 'package:flutter/material.dart';
import 'package:pda_scanner/pda_listener_mixin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'cubit/sscc_cubit.dart';

class SsccScreen extends StatefulWidget {
  @override
  _SsccScreenState createState() => _SsccScreenState();
}

class _SsccScreenState extends State<SsccScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('appBar_Acquisition'.tr()),
      ),
      body: SsccWidget(),
    );
  }
}

class SsccWidget extends StatefulWidget {
  SsccWidget({Key key}) : super(key: key);

  @override
  _SsccWidgetState createState() => _SsccWidgetState();
}

class _SsccWidgetState extends State<SsccWidget>
    with PdaListenerMixin<SsccWidget> {
  TextEditingController sscccontroller = TextEditingController();
  TextEditingController eancontroller = TextEditingController();
  TextEditingController dmcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height - 80;
    return BlocConsumer<SsccCubit, SsccState>(listener: (context, state) {
      if (state is SsccError) {
        final snackBar = SnackBar(
          content: Text('${state.message}'),
          backgroundColor: Colors.red,
        );

        // Find the Scaffold in the widget tree and use
        // it to show a SnackBar.
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }, builder: (context, state) {
      if (state is SsccLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is SsccLoaded) {
        sscccontroller.text = state.ssccValue;
        eancontroller.text = state.eanValue;
        dmcontroller.text = state.dmValue;
        return Container(
            margin: EdgeInsets.only(left: 16, right: 16),
            child: SingleChildScrollView(
              child: SizedBox(
                height: height,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${state.eanDescription}',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          enabled: false,
                          controller: sscccontroller,
                          decoration: InputDecoration(
                            labelText: 'acquisition_SSCC_scan'.tr(),
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
                          height: 8,
                        ),
                        Visibility(
                          visible: state.eanVisibility,
                          child: TextFormField(
                            enabled: false,
                            controller: eancontroller,
                            decoration: InputDecoration(
                              labelText: 'acquisition_EAN_scan'.tr(),
                              // suffixIcon: IconButton(
                              //     icon: Icon(
                              //       Icons.clear,
                              //       color: Color(0xff3678AF),
                              //     ),
                              //     onPressed: () => eancontroller.clear())
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Visibility(
                          visible: state.dmVisibility,
                          child: TextFormField(
                            enabled: false,
                            controller: dmcontroller,
                            decoration: InputDecoration(
                              labelText: 'acquisition_DM_scan'.tr(),
                              // suffixIcon: IconButton(
                              //     icon: Icon(
                              //       Icons.clear,
                              //       color: Color(0xff3678AF),
                              //     ),
                              //     onPressed: () => kmcontroller.clear())
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("acquisition_KM_SSCC".tr()),
                            Text(
                              '${state.ssccCount}',
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("acquisition_KM_EAN".tr()),
                            Text(
                              '${state.eanCount}',
                              style: Theme.of(context).textTheme.headline4,
                            )
                          ],
                        )
                      ],
                    ),
                    // Spacer(),
                    // Container(
                    //   color: Color(0xffE3F2FF),
                    //   height: 80,
                    //   child: Center(
                    //       child: Container(
                    //     margin: EdgeInsets.all(16),
                    //     child: SizedBox.expand(
                    //         child: RaisedButton(
                    //       child: Text('Печать КМ'),
                    //     )),
                    //   )),
                    // )
                  ],
                ),
              ),
            ));
      }
      return null;
    });
  }

  @override
  void onEvent(Object event) {
    String scanCode = event;
    context.bloc<SsccCubit>().scanSscc(scanCode);
  }

  @override
  void onError(Object error) {}
}
