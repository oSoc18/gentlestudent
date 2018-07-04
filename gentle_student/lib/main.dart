import 'package:flutter/material.dart';

import 'pages/login/login_page.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context)=>LoginPage(),
  };

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Gentle Student',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'NeoSansPro',
      ),
      home: LoginPage(),
      routes: routes
    );
  }
}