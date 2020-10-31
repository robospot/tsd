import 'package:flutter/material.dart';
import 'package:tsd/screens/appsettings/appsettings.dart';
import 'package:tsd/screens/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tsd/utils/authentication/authentication_service.dart';
import 'package:tsd/utils/authentication/bloc/authentication_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = RepositoryProvider.of<AuthenticationService>(context);
    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('appBar_Authorization'.tr()),
          actions: [
            IconButton(
                icon: Icon(Icons.settings),
                onPressed: () => clickOnSettings(context))
          ],
        ),
        body: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authBloc, authService),
          child: LoginWidget(),
        ));
  }
}

clickOnSettings(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => AppSettings(),
  ));
}

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          print('state: $state');
          if (state is LoginFailure) {
            final snackBar = SnackBar(
                backgroundColor: Colors.red,
                content: Text("Неправильная учетная запись или пароль"));
            return Scaffold.of(context).showSnackBar(snackBar);
          }
        },
        child: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.symmetric(horizontal: 64, vertical: 64),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'login_userName'.tr(),
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  TextFormField(controller: _usernameController),
                  SizedBox(
                    height: 24,
                  ),
                  Text('login_userPassword'.tr(),
                      style: Theme.of(context).textTheme.headline4),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    height: 60,
                    child: RaisedButton(
                      onPressed: () => loginAction(context),
                      child: Text("login_signIn".tr()),
                    ),
                  )
                ],
              )),
        ));
  }

  loginAction(BuildContext context) {
    context.bloc<LoginBloc>().add(
        LoginSubmitted(_usernameController.text, _passwordController.text));
  }
}
