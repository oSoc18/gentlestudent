import 'package:Gentle_Student/navigation/map_list_page.dart';
import 'package:Gentle_Student/pages/information/information_page.dart';
import 'package:Gentle_Student/pages/user/user_page.dart';
import 'package:flutter/material.dart';

import 'package:beacons/beacons.dart';
import 'package:local_notifications/local_notifications.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

  static const AndroidNotificationChannel channel = const AndroidNotificationChannel(
      id: 'default_notification',
      name: 'Default',
      description: 'Grant this app the ability to show notifications',
      importance: AndroidNotificationChannelImportance.HIGH
  );
  
  HomePage(){
    bool notified = false;

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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 1; // Index of currently opened tab.
  InformationPage informationPage = new InformationPage(); // Page that corresponds with the first tab.
  MapListPage mapListPage = new MapListPage(); // Page that corresponds with the second tab.
  UserPage userPage = new UserPage(); // Page that corresponds with the third tab.
  List<Widget> pages; // List of all pages that can be opened from our BottomNavigationBar.
                      // Index 0 represents the page for the 0th tab, index 1 represents the page for the 1st tab etc...
  Widget currentPage; // Page that is open at the moment.

  @override
  void initState() {
    super.initState();
    pages = [informationPage, mapListPage, userPage]; // Populate our pages list.
    currentPage = mapListPage; // Setting the first page that we'd like to show our user.
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Here we create our BottomNavigationBar.
    final BottomNavigationBar navBar = new BottomNavigationBar(
      currentIndex: currentTab, // Our currentIndex will be the currentTab value. So we need to update this whenever we tab on a new page!
      onTap: (int numTab) { // numTab will be the index of the tab that is pressed.
        setState(() { // Setting the state so we can show our new page.
          currentTab = numTab; // Updating our currentTab with the tab that is pressed.
          currentPage = pages[numTab]; // Updating the page that we'd like to show to the user.
        });
      },
      items: <BottomNavigationBarItem>[ // Visuals, see docs for more information: https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html
        new BottomNavigationBarItem( //numTab 0
          icon: new Icon(Icons.info),
          title: new Text("Informatie")
        ),
        new BottomNavigationBarItem( //numTab 1
          icon: new Icon(Icons.location_on),
          title: new Text("Leerkansen")
        ),
        new BottomNavigationBarItem( //numTab 2
          icon: new Icon(Icons.account_circle),
          title: new Text("Gebruiker")
        )
      ],

    );

    return new Scaffold(
      bottomNavigationBar: navBar, // Assigning our navBar to the Scaffold's bottomNavigationBar property.
      body: currentPage, // The body will be the currentPage. Which we update when a tab is pressed.
    );
  }
}