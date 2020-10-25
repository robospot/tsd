import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:tsd/screens/home/cubit/home_cubit.dart';
import 'package:tsd/screens/packingList/cubit/packinglist_cubit.dart';
import 'package:tsd/screens/sscc/cubit/sscc_cubit.dart';
import 'app.dart';
import 'utils/authentication/authentication_repository.dart';
import 'utils/authentication/user_repository.dart';
import 'utils/moor/moor_database.dart';


void main() {
  //Инициализация настроек
  Settings.init();

  //Moor db
  final db = AppDatabase();

  runApp(EasyLocalization(
    child:MultiBlocProvider(providers: [
    BlocProvider<SsccCubit>(create: (BuildContext context) => SsccCubit()),
    BlocProvider<PackinglistCubit>(create: (BuildContext context) => PackinglistCubit()),
    BlocProvider<HomeCubit>(create: (BuildContext context) => HomeCubit(db)),
  ], child: App(
    authenticationRepository: AuthenticationRepository(),
    userRepository: UserRepository(),
  )),
  supportedLocales: [
      Locale('en', 'US'),
      Locale('ru', 'RU')
    ],
  path: 'assets/translations', 
   fallbackLocale: Locale('en', 'US'),
  ));
}

// class MyApp extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
    
//     return MaterialApp(debugShowCheckedModeBanner: false,
//         title: 'Flutter Demo',
//         theme: ThemeData(
//           appBarTheme: AppBarTheme(
//             color: Color(0xff445E75),
//             centerTitle: true,
//           ),
//           buttonTheme: ButtonThemeData(
//             textTheme: ButtonTextTheme.primary,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8.0)),
//             buttonColor: Color(0xff3678AF),
//           ),
//           textTheme: TextTheme(
//               headline4: TextStyle(
//                   fontFamily: 'Open Sans',
//                   fontWeight: FontWeight.w300,
//                   color: Color(0xff445E75))),
//           inputDecorationTheme: InputDecorationTheme(
//             filled: true,
//             fillColor: Color(0xff1A76767B),
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide.none),
//           ),
//           primarySwatch: Colors.blue,
//           visualDensity: VisualDensity.adaptivePlatformDensity,
//         ),
//         // home: LoginScreen(),
//         initialRoute: '/',
//         routes: {
//           '/': (context) => LoginScreen(),
//           '/acquisition': (context) => SsccScreen(),
//           '/home': (context) => HomeScreen(),
//           '/packingList': (context) => PackingListScreen(),
//         });
//   }
// }
