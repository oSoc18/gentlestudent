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

import 'dart:async';
import 'package:async/async.dart';
import 'package:beacons/beacons.dart';
import 'package:local_notifications/local_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_local_notifications/initialization_settings.dart';
import 'package:flutter_local_notifications/notification_details.dart';
import 'package:flutter_local_notifications/platform_specifics/android/initialization_settings_android.dart';
import 'package:flutter_local_notifications/platform_specifics/android/notification_details_android.dart';
import 'package:flutter_local_notifications/platform_specifics/ios/initialization_settings_ios.dart';
import 'package:flutter_local_notifications/platform_specifics/ios/notification_details_ios.dart';
import 'package:flutter/widgets.dart';

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

  static const AndroidNotificationChannel channel = const AndroidNotificationChannel(
      id: 'default_notification',
      name: 'Default',
      description: 'Grant this app the ability to show notifications',
      importance: AndroidNotificationChannelImportance.HIGH
  );

  MyApp() {
    bool notified = false;

    BeaconRegion region = new BeaconRegionIBeacon(
      identifier: 'test',
      proximityUUID: 'B9407F30-F5F8-466E-AFF9-25556B57FE6D',
    );

    Beacons.ranging(
      region: new BeaconRegionIBeacon(
        identifier: 'hallo',
        proximityUUID: 'B9407F30-F5F8-466E-AFF9-25556B57FE6D',
        /*major: 43488,
        minor: 54570,*/
      ),
      inBackground: true, // continue the ranging operation in background or not, see below
    ).listen((result) {
      // result contains a list of beacons
      // list can be empty if no matching beacons were found in range
      if(result.isSuccessful){
        if(result.beacons.isNotEmpty){
          if(result.beacons.first.ids[2] == '54570') {
            if(!notified) {
              notified = true;
              LocalNotifications.createAndroidNotificationChannel(
                  channel: channel);
              LocalNotifications.createNotification(
                  title: "Beacon nearby",
                  content: "In range of an opportunity!",
                  id: 0,
                  androidSettings: new AndroidSettings(
                      channel: channel
                  )
              );
            }
          }
        }
        else{

          if(notified) {
            LocalNotifications.createAndroidNotificationChannel(
                channel: channel);
            LocalNotifications.createNotification(
                title: "out of range",
                content: "In range of an opportunity!",
                id: 0,
                androidSettings: new AndroidSettings(
                    channel: channel
                )
            );
          }

          notified = false;
        }
      }
    });
  }

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