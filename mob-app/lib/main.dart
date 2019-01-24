import 'package:Gentle_Student/navigation/home_page.dart';
import 'package:Gentle_Student/navigation/map_list_page.dart';
import 'package:Gentle_Student/pages/information/experiences/experiences_page.dart';
import 'package:Gentle_Student/pages/information/news/news_page.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'pages/login/login_page.dart';
import 'pages/register/register_page.dart';
import 'pages/map/map_page.dart';
import 'pages/opportunity_list/opportunity_list_page.dart';
import 'pages/information/information_page.dart';
import 'pages/user/user_page.dart';
import 'pages/user/backpack/backpack_page.dart';
import 'pages/user/profile/profile_page.dart';
import 'pages/user/my_learning_opportunities/my_learning_opportunities_page.dart';
import 'pages/user/favorites/favorites_page.dart';
import 'pages/user/settings/settings_page.dart';

FirebaseUser firebaseUser;

void main() async {
  firebaseUser = await FirebaseUtils.firebaseUser;
  runApp(MyApp());
}

final routes = <String, WidgetBuilder>{
  HomePage.tag: (context) => HomePage(),
  MapListPage.tag: (context) => MapListPage(),
  LoginPage.tag: (context) => LoginPage(),
  RegisterPage.tag: (context) => RegisterPage(),
  MapPage.tag: (context) => MapPage(),
  InformationPage.tag: (context) => InformationPage(),
  UserPage.tag: (context) => UserPage(),
  OpportunityListPage.tag: (context) => OpportunityListPage(),
  BackPackPage.tag: (context) => BackPackPage(),
  ProfilePage.tag: (context) => ProfilePage(),
  MyLearningOpportunitiesPage.tag: (context) => MyLearningOpportunitiesPage(),
  FavoritesPage.tag: (context) => FavoritesPage(),
  SettingsPage.tag: (context) => SettingsPage(),
  ExperiencesPage.tag: (context) => ExperiencesPage(),
  NewsPage.tag: (context) => NewsPage(),
};

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
          routes: routes,
        );
      },
    );
  }
}
