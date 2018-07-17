import 'package:Gentle_Student/navigation/home_page.dart';
import 'package:Gentle_Student/pages/information/experiences/experiences_page.dart';
import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';

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
import 'pages/information/tutorial/tutorial_page.dart';


//API key for Google Maps
const API_KEY = "AIzaSyDl5W6GeM02xFCyASmGvKtoP3fJ_xhvUvM";

void main() {
  MapView.setApiKey(API_KEY);
  runApp(new MyApp());
}

//This widget is the root of the application
class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context)=>HomePage(),
    LoginPage.tag: (context)=>LoginPage(),
    RegisterPage.tag: (context)=>RegisterPage(),
    MapPage.tag: (context)=>MapPage(),
    InformationPage.tag: (context)=>InformationPage(),
    PrivacyPolicyPage.tag: (context)=>PrivacyPolicyPage(),
    AboutUsPage.tag: (context)=>AboutUsPage(),
    UserPage.tag: (context)=>UserPage(),
    OpportunityListPage.tag: (context)=>OpportunityListPage(),
    BackPackPage.tag: (context)=>BackPackPage(),
    ProfilePage.tag: (context)=>ProfilePage(),
    MyLearningOpportunitiesPage.tag: (context)=>MyLearningOpportunitiesPage(),
    FavoritesPage.tag: (context)=>FavoritesPage(),
    SettingsPage.tag: (context)=>SettingsPage(),
    TutorialPage.tag: (context)=>TutorialPage(),
    ExperiencesPage.tag: (context)=>ExperiencesPage()
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
      home: new LoginPage(),
      routes: routes
    );
  }
}