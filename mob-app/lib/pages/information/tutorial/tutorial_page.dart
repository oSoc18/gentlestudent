import 'package:Gentle_Student/navigation/home_page.dart';
import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

//This page is used to display the tutorial
//It is shown to a user when on first login
//The state doesn't change so it can be a StatelessWidget
class TutorialPage extends StatelessWidget {
  //This tag allows us to navigate to the TutorialPage
  static String tag = "tutorial-page";

  //Declaration of the variables
  final bool _firstLogin;

  //Constructor
  TutorialPage(this._firstLogin);

  //The three pages of the tutorial
  final pages = [

    //Bluetooth page
    new PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        iconImageAssetPath: 'assets/tutorial/bluetooth.png', //A small icon at the bottom of the page
        iconColor: null,
        bubbleBackgroundColor: null,
        body: Text(
          'Zet je bluetooth aan, het verbruikt niet zoveel energie!',
        ),
        title: Text('Bluetooth'),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset(
          'assets/tutorial/bluetooth.png', //The main image of this page
          height: 400.0,
          width: 400.0,
          alignment: Alignment.center,
        )),

    //Scan page
    new PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/tutorial/beacon.png', //A small icon at the bottom of the page
      iconColor: null,
      bubbleBackgroundColor: null,
      body: Text(
        'Scan om te zien of er beacons in de buurt zijn.',
      ),
      title: Text('Scannen'),
      mainImage: Image.asset(
        'assets/tutorial/beacon.png', //The main image of this page
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),

    //Challenge page
    new PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconImageAssetPath: 'assets/tutorial/challenge.png', //A small icon at the bottom of the page
      iconColor: null,
      bubbleBackgroundColor: null,
      body: Text(
        'Ga de uitdaging aan!',
      ),
      title: Text('Uitdaging'),
      mainImage: Image.asset(
        'assets/tutorial/challenge.png', //The main image of this page
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Builder(
        builder: (context) => new IntroViewsFlutter(
              pages,
              onTapDoneButton: () {
                //If you come from the LoginPage, you proceed to the HomePage
                //Otherwise, you return to the previous page
                if (_firstLogin) {
                  Navigator.of(context).pushReplacementNamed(HomePage.tag);
                } else {
                  Navigator.of(context).pop();
                }
              },
              showSkipButton: true,
              skipText: Text("Overslaan"),
              doneText: Text("Klaar"),
              pageButtonTextStyles: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
      ),
    );
  }
}
