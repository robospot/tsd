import 'package:flutter/material.dart';

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
          IconButton(icon: Icon(Icons.settings), onPressed: clickOnSettings())
        ],
      ),
      body: LoginWidget(),
    );
  }
}

clickOnSettings() {}

class LoginWidget extends StatefulWidget {
  LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 64, vertical: 64),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Логин',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextFormField(),
            SizedBox(
              height: 47,
            ),
            Text('Пароль', style: Theme.of(context).textTheme.headline4),
            TextFormField(),
            SizedBox(
              height: 72,
            ),
            RaisedButton(
              onPressed: () => loginAction(context),
              child: Text("Авторизоваться"),
            )
          ],
        ));
  }
}

loginAction(BuildContext context) {
  Navigator.of(context).pushReplacementNamed('acquisition');
}
