import 'package:Gentle_Student/views/pages/authentication/login_page.dart';
import 'package:Gentle_Student/views/pages/authentication/register_page.dart';
import 'package:Gentle_Student/views/pages/information/experiences/experiences_page.dart';
import 'package:Gentle_Student/views/pages/information/information_page.dart';
import 'package:Gentle_Student/views/pages/information/news/news_page.dart';
import 'package:Gentle_Student/views/pages/opportunities/home_page.dart';
import 'package:Gentle_Student/views/pages/opportunities/map_list_page.dart';
import 'package:Gentle_Student/views/pages/opportunities/map_page.dart';
import 'package:Gentle_Student/views/pages/opportunities/opportunity_list_page.dart';
import 'package:Gentle_Student/views/pages/user/backpack/backpack_page.dart';
import 'package:Gentle_Student/views/pages/user/favorites/favorites_page.dart';
import 'package:Gentle_Student/views/pages/user/my_learning_opportunities/my_learning_opportunities_page.dart';
import 'package:Gentle_Student/views/pages/user/profile/profile_page.dart';
import 'package:Gentle_Student/views/pages/user/settings/settings_page.dart';
import 'package:Gentle_Student/views/pages/user/user_page.dart';
import 'package:flutter/material.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
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
}
