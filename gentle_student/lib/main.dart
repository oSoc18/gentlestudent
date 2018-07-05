import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

import 'pages/login/login_page.dart';
import 'pages/register/register_page.dart';
import 'pages/home/home_page.dart';

const API_KEY = "AIzaSyDl5W6GeM02xFCyASmGvKtoP3fJ_xhvUvM";

void main() {
  MapView.setApiKey(API_KEY);
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context)=>LoginPage(),
    RegisterPage.tag: (context)=>RegisterPage(),
    HomePage.tag: (context)=>HomePage(),
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