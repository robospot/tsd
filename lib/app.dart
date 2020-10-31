import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsd/screens/login/login_page.dart';
import 'screens/home/home_screen.dart';
import 'screens/packingList/packingList_screen.dart';
import 'screens/sscc/sscc_screen.dart';
import 'utils/authentication/bloc/authentication_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class App extends StatelessWidget {
  const App({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppView();
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  // final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // navigatorKey: _navigatorKey,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // show home page
            return HomeScreen();
          }
          // otherwise show login page
          return LoginPage();
        },
      ),

      routes: {
        '/acquisition': (context) => SsccScreen(),
        '/home': (context) => HomeScreen(),
        '/packingList': (context) => PackingListScreen(),
      },
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          color: Color(0xff445E75),
          centerTitle: true,
        ),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          buttonColor: Color(0xff3678AF),
        ),
        textTheme: TextTheme(
            headline4: TextStyle(
                fontFamily: 'Open Sans',
                fontWeight: FontWeight.w300,
                color: Color(0xff445E75)),
            bodyText1: TextStyle(
                fontSize: 24,
                fontFamily: 'Open Sans',
                // fontWeight: FontWeight.w300,
                color: Color(0xff445E75)),
            bodyText2: TextStyle(
                fontFamily: 'Open Sans',
                fontSize: 16,
                // fontWeight: FontWeight.w300,
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
