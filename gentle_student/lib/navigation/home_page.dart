import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/navigation/map_list_page.dart';
import 'package:Gentle_Student/pages/information/information_page.dart';
import 'package:Gentle_Student/pages/opportunity_details/opportunity_details_page.dart';
import 'package:Gentle_Student/pages/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:Gentle_Student/data/api.dart';
import 'package:beacons/beacons.dart';
import 'package:local_notifications/local_notifications.dart';
import 'package:Gentle_Student/models/beacon.dart';

class HomePage extends StatefulWidget {
  static String tag = 'home-page';

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

  List<IBeacon> _beaconList = [];
  List<String> _keyList = [];
  Opportunity _opportunity;
  Badge _badge;
  Issuer _issuer;
  Address _address;
  int _notId = 0;


  static const AndroidNotificationChannel channel = const AndroidNotificationChannel(
      id: 'default_notification',
      name: 'Default',
      description: 'Grant this app the ability to show notifications',
      importance: AndroidNotificationChannelImportance.HIGH
  );

  @override
  void initState() {
    super.initState();
    _beaconRanging();//start scanning for beacons
    _loadBeacons();//load all the beacons from the database into a list
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

  _loadBeacons() async {
    final beaconApi = new BeaconApi();
    final beacons = await beaconApi.getAllBeacons();
    setState(() {
      _beaconList = beacons;
      for(IBeacon beacon in _beaconList)
        {
          _keyList.add(beacon.beaconId);
        }
    });
  }

  _loadFromFirebase(String beaconkey) async {
    final opportunityApi = new OpportunityApi();
    final beaconApi = new BeaconApi();
    final badgeApi = new BadgeApi();
    final issuerApi = new IssuerApi();
    final addressApi = new AddressApi();
    final beacon = await beaconApi.getBeaconById(beaconkey);
    final opportunity = await opportunityApi.getOpportunityById(beacon.opportunityId);
    final badge = await badgeApi.getBadgeById(opportunity.badgeId);
    final issuer = await issuerApi.getIssuerById(opportunity.issuerId);
    final address = await addressApi.getAddressById(opportunity.addressId);
    setState(() {
      _opportunity = opportunity;
      _badge = badge;
      _issuer = issuer;
      _address = address;
    });
  }

  _navigateToOpportunityDetails(String payload) async {

    await LocalNotifications.removeNotification(int.parse(payload));
    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) =>
        new OpportunityDetailsPage(_opportunity, _badge, _issuer, _address),
      ),
    );
  }

  _beaconRanging() {
    bool notified = false;
    _notId = 0;
    Beacons.ranging(
      region: new BeaconRegionIBeacon(
        identifier: 'hallo',
        proximityUUID: 'B9407F30-F5F8-466E-AFF9-25556B57FE6D',
      ),
      inBackground: true,
    ).listen((result) async {
      if(result.isSuccessful){
        if(result.beacons.isNotEmpty){
          String beaconKey = result.beacons.first.ids[1] + result.beacons.first.ids[2];
          print(beaconKey);
          if(_keyList.contains(beaconKey) ) {
            if(!notified) {
              notified = true;

              await _loadFromFirebase(beaconKey);


              await LocalNotifications.createAndroidNotificationChannel(
                  channel: channel);

              int id = await LocalNotifications.createNotification(
                  title: "Beacon gevonden",
                  content: "Er is een leerkans in de buurt!",
                  id: _notId,
                  imageUrl: _badge.image,
                  androidSettings: new AndroidSettings(
                      channel: channel,
                  ),
                  iOSSettings: new IOSSettings(
                    presentWhileAppOpen: true,
                  ),
                  onNotificationClick: new NotificationAction(
                      actionText: "some action",
                      callback: _navigateToOpportunityDetails,
                      payload: _notId.toString())
              );
              _notId ++;
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
                id: _notId,
                androidSettings: new AndroidSettings(
                    channel: channel
                )
            );
          }

          notified = false;
          _notId ++;

        }
      }
    });
  }
}