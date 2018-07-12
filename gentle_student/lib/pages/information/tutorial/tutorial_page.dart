import 'package:flutter/material.dart';
import 'package:intro_views_flutter/Models/page_view_model.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';

class TutorialPage extends StatelessWidget {
  static String tag = "tutorial-page";
  final pages = [
    new PageViewModel(
        pageColor: const Color(0xFF03A9F4),
        iconImageAssetPath: 'assets/tutorial/bluetooth.png',
        iconColor: null,
        bubbleBackgroundColor: null,
        body: Text(
          'Zet je bluetooth aan, het verbruikt niet zoveel energie!',
        ),
        title: Text('Bluetooth'),
        textStyle: TextStyle(color: Colors.white),
        mainImage: Image.asset(
          'assets/tutorial/bluetooth.png',
          height: 400.0,
          width: 400.0,
          alignment: Alignment.center,
        )),
    new PageViewModel(
      pageColor: const Color(0xFF8BC34A),
      iconImageAssetPath: 'assets/tutorial/beacon.png',
      iconColor: null,
      bubbleBackgroundColor: null,
      body: Text(
        'Scan om te zien of er beacons in de buurt zijn.',
      ),
      title: Text('Scannen'),
      mainImage: Image.asset(
        'assets/tutorial/beacon.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      textStyle: TextStyle(color: Colors.white),
    ),
    new PageViewModel(
      pageColor: const Color(0xFF607D8B),
      iconImageAssetPath: 'assets/tutorial/challenge.png',
      iconColor: null,
      bubbleBackgroundColor: null,
      body: Text(
        'Ga de uitdaging aan!',
      ),
      title: Text('Uitdaging'),
      mainImage: Image.asset(
        'assets/tutorial/challenge.png',
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
                Navigator.of(context).pop();
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
