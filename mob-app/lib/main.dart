import 'package:Gentle_Student/routes.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:Gentle_Student/views/pages/authentication/login_page.dart';
import 'package:Gentle_Student/views/pages/opportunities/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

FirebaseUser firebaseUser;

void main() async {
  firebaseUser = await FirebaseUtils.firebaseUser;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
            primarySwatch: Colors.lightBlue,
            accentColor: Colors.lightBlue,
            textSelectionHandleColor: Colors.lightBlue,
            brightness: brightness,
            fontFamily: 'NeoSansPro',
          ),
      themedWidgetBuilder: (context, theme) {
        return MaterialApp(
          title: 'GentleStudent',
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: firebaseUser != null ? HomePage() : LoginPage(),
          routes: Routes.routes,
        );
      },
    );
  }
}
