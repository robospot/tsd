import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:tsd/screens/home/home_screen.dart';
import 'package:tsd/screens/packingList/packingList_screen.dart';
import 'package:tsd/screens/sscc/cubit/sscc_cubit.dart';
import 'screens/login/login_screen.dart';
import 'screens/sscc/sscc_screen.dart';

void main() {
  //Инициализация настроек
  Settings.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<SsccCubit>(create: (BuildContext context) => SsccCubit()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Color(0xff445E75),
            centerTitle: true,
          ),
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            buttonColor: Color(0xff3678AF),
          ),
          textTheme: TextTheme(
              headline4: TextStyle(
                  fontFamily: 'Open Sans',
                  fontWeight: FontWeight.w300,
                  color: Color(0xff445E75))),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Color(0xff1A76767B),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
          ),
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        // home: LoginScreen(),
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          '/acquisition': (context) => SsccScreen(),
          '/home': (context) => HomeScreen(),
          '/packingList': (context) => PackingListScreen(),
        });
  }
}
