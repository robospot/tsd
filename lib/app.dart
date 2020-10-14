import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_page.dart';
import 'screens/login/login_screen.dart';
import 'screens/packingList/packingList_screen.dart';
import 'screens/splash/view/splash_page.dart';
import 'screens/sscc/sscc_screen.dart';
import 'utils/authentication/authentication_repository.dart';
import 'utils/authentication/bloc/authentication_bloc.dart';
import 'utils/authentication/user_repository.dart';

class App extends StatelessWidget {
  const App({
    Key key,
    @required this.authenticationRepository,
    @required this.userRepository,
  })  : assert(authenticationRepository != null),
        assert(userRepository != null),
        super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
          userRepository: userRepository,
        ),
        child: AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeScreen.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
      routes: {
          '/': (context) => LoginScreen(),
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
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
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
                  color: Color(0xff445E75))
                  ),
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
    );
  }
}
