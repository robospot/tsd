import 'package:flutter/material.dart';
import 'package:tsd/screens/appsettings/appsettings.dart';
import 'package:tsd/screens/login/bloc/login_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => clickOnSettings(context))
        ],
      ),
      body: LoginWidget(),
    );
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
    return SingleChildScrollView(
      child: Container(
          margin: EdgeInsets.symmetric(horizontal: 64, vertical: 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Логин',
                style: Theme.of(context).textTheme.headline4,
              ),
              TextFormField(controller: _usernameController),
              SizedBox(
                height: 47,
              ),
              Text('Пароль', style: Theme.of(context).textTheme.headline4),
              TextFormField(obscureText: true,
                controller: _passwordController,
              ),
              SizedBox(
                height: 72,
              ),
              RaisedButton(
                onPressed: () => loginAction(context),
                child: Text("Авторизоваться"),
              )
            ],
          )),
    );
    
  }
 loginAction(BuildContext context) {
    context.bloc<LoginBloc>().add(
        LoginSubmitted(_usernameController.text, _passwordController.text));
  }
 
}
