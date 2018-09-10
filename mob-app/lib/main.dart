import 'package:Gentle_Student/data/database_helper.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:Gentle_Student/navigation/home_page.dart';
import 'package:Gentle_Student/navigation/map_list_page.dart';
import 'package:Gentle_Student/pages/information/experiences/experiences_page.dart';
import 'package:Gentle_Student/pages/information/news/news_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

import 'pages/login/login_page.dart';
import 'pages/register/register_page.dart';
import 'pages/map/map_page.dart';
import 'pages/opportunity_list/opportunity_list_page.dart';
import 'pages/information/information_page.dart';
import 'pages/information/privacy_policy/privacy_policy_page.dart';
import 'pages/information/about_us/about_us_page.dart';
import 'pages/user/user_page.dart';
import 'pages/user/backpack/backpack_page.dart';
import 'pages/user/profile/profile_page.dart';
import 'pages/user/my_learning_opportunities/my_learning_opportunities_page.dart';
import 'pages/user/favorites/favorites_page.dart';
import 'pages/user/settings/settings_page.dart';

//The Singleton of the local database
final db = new DatabaseHelper();

void main() async {
  //Getting the user from the database
  User localUser = await db.getUser();
  if (localUser != null) {
    try {
      //Authenticating the user via Firebase
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: localUser.username,
        password: localUser.password,
      );
      //The authentication is succesful and the user will go to the HomePage
      runApp(new MyAppHome());
    } catch (Error) {
      //If the login fails, the user doesn't have an internet connection
      //Or the login credentials have changed
      //The user will return to the LoginPage
      runApp(new MyApp());
    }
  } else {
    //The user isn't logged in and will go to the LoginPage
    runApp(new MyApp());
  }
}

//The routes for navigation containing all pages apart from detail pages
final routes = <String, WidgetBuilder>{
  HomePage.tag: (context) => HomePage(),
  MapListPage.tag: (context) => MapListPage(),
  LoginPage.tag: (context) => LoginPage(),
  RegisterPage.tag: (context) => RegisterPage(),
  MapPage.tag: (context) => MapPage(),
  InformationPage.tag: (context) => InformationPage(),
  PrivacyPolicyPage.tag: (context) => PrivacyPolicyPage(),
  AboutUsPage.tag: (context) => AboutUsPage(),
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

//This widget is the root of the application (first time)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //DynamicTheme allows us to switch between light and dark mode
    return new DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => new ThemeData(
            primarySwatch: Colors.lightBlue,
            brightness: brightness,
            fontFamily: 'NeoSansPro',
          ),
      themedWidgetBuilder: (context, theme) {
        //The root of our application
        return new MaterialApp(
            title: 'GentleStudent',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: new LoginPage(),
            routes: routes);
      },
    );
  }
}

//This widget is the root of the application (after first login)
class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //DynamicTheme allows us to switch between light and dark mode
    return new DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => new ThemeData(
              primarySwatch: Colors.lightBlue,
              brightness: brightness,
              fontFamily: 'NeoSansPro',
            ),
        themedWidgetBuilder: (context, theme) {
          //The root of our application
          return new MaterialApp(
            title: 'GentleStudent',
            debugShowCheckedModeBanner: false,
            home: new HomePage(),
            routes: routes,
            theme: theme,
          );
        });
  }
}
