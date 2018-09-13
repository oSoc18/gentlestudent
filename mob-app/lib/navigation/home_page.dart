import 'dart:async';
import 'dart:collection';

import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/beacon.dart';
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

//This page is going to be the first page users see after they log in
//It consists out of 3 other pages but more of that in a bit
//The state of this page may change so that's why we use a StatefulWidget
class HomePage extends StatefulWidget {
  //This tag allows us to navigate to the HomePage
  static String tag = 'home-page';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //Variables used for navigation using the bottom navigation bar
  int currentTab = 1; // Index of currently opened tab.
  InformationPage informationPage =
      new InformationPage(); // Page that corresponds with the first tab.
  MapListPage mapListPage =
      new MapListPage(); // Page that corresponds with the second tab.
  UserPage userPage =
      new UserPage(); // Page that corresponds with the third tab.
  List<Widget>
      pages; // List of all pages that can be opened from our BottomNavigationBar.
  // Index 0 represents the page for the 0th tab, index 1 represents the page for the 1st tab etc...
  Widget currentPage; // Page that is open at the moment.

  //Declaration of the other variables
  List<String> _keyList = [];
  Set<String> _notifiedKeyList = new Set<String>();
  BeaconApi _beaconApi;
  OpportunityApi _opportunityApi;
  BadgeApi _badgeApi;
  IssuerApi _issuerApi;
  AddressApi _addressApi;
  List<Opportunity> _opportunities;
  List<Badge> _badges;
  List<Issuer> _issuers;
  List<Address> _addresses;
  int _notId = 0;
  HashMap<int, Opportunity> _notIdOpportunity = new HashMap();
  HashMap<String, int> _beaconNumberOfOpp = new HashMap();

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Scan for beacons
  // - Load beacons from Firebase
  // - Load pages and the current page for navigation
  @override
  void initState() {
    super.initState();
    _loadBeacons(); //load all the beacons from the database into a list
    _beaconRanging(); //start scanning for beacons
    pages = [
      informationPage,
      mapListPage,
      userPage
    ]; // Populate our pages list.
    currentPage =
        mapListPage; // Setting the first page that we'd like to show our user.
  }

  @override
  Widget build(BuildContext context) {
    // Here we create our BottomNavigationBar.
    final BottomNavigationBar navBar = new BottomNavigationBar(
      fixedColor: Colors.lightBlue, //Color of the selected tab
      currentIndex:
          currentTab, // Our currentIndex will be the currentTab value. So we need to update this whenever we tab on a new page!
      onTap: (int numTab) {
        // numTab will be the index of the tab that is pressed.
        setState(() {
          // Setting the state so we can show our new page.
          currentTab =
              numTab; // Updating our currentTab with the tab that is pressed.
          currentPage = pages[
              numTab]; // Updating the page that we'd like to show to the user.
        });
      },
      items: <BottomNavigationBarItem>[
        // Visuals, see docs for more information: https://docs.flutter.io/flutter/material/BottomNavigationBar-class.html
        new BottomNavigationBarItem(
            //numTab 0
            icon: new Icon(Icons.info),
            title: new Text("Informatie")),
        new BottomNavigationBarItem(
            //numTab 1
            icon: new Icon(Icons.location_on),
            title: new Text("Leerkansen")),
        new BottomNavigationBarItem(
            //numTab 2
            icon: new Icon(Icons.account_circle),
            title: new Text("Gebruiker"))
      ],
    );

    return new Scaffold(
      bottomNavigationBar:
          navBar, // Assigning our navBar to the Scaffold's bottomNavigationBar property.
      body:
          currentPage, // The body will be the currentPage. Which we update when a tab is pressed.
    );
  }

  //API call to load the beacons from the Firebase
  _loadBeacons() async {
    final opportunityApi = new OpportunityApi();
    final beaconApi = new BeaconApi();
    final badgeApi = new BadgeApi();
    final issuerApi = new IssuerApi();
    final addressApi = new AddressApi();
    final beacons = await beaconApi.getAllBeacons();
    final keyList = new List<String>();
    beacons.forEach((beacon) => keyList.add(beacon.beaconId));
    if (this.mounted) {
      setState(() {
        _beaconApi = beaconApi;
        _badgeApi = badgeApi;
        _issuerApi = issuerApi;
        _addressApi = addressApi;
        _opportunityApi = opportunityApi;
        _keyList = keyList;
      });
    }
  }

  //Creating a notification channel to send notification to phones with Android Oreo or newer
  static const AndroidNotificationChannel channel =
      const AndroidNotificationChannel(
          id: 'default_notification',
          name: 'Default',
          description: 'Grant this app the ability to show notifications',
          importance: AndroidNotificationChannelImportance.DEFAULT);

  //Get all opportunities linked to a beacon
  Future<List<Opportunity>> getBeaconOpportunitiesReady(IBeacon beacon) async {
    List<Opportunity> opportunities =
        _opportunities == null ? new List<Opportunity>() : _opportunities;
    Opportunity opportunity;
    for (int i = 0; i < beacon.opportunities.length; i++) {
      opportunity = await _opportunityApi
          .getOpportunityById(beacon.opportunities.keys.toList()[i]);
      opportunities.add(opportunity);
      print(opportunity.title);
      _notIdOpportunity[_notId] = opportunity;
      print(_notIdOpportunity[_notId].title);
      _notId++;
    }
    return opportunities;
  }

  //Get all addresses from opportunities linked to a beacon
  Future<List<Address>> getAddressesFromBeaconOpportunities(
      List<Opportunity> opportunities) async {
    List<Address> addresses =
        _addresses == null ? new List<Address>() : _addresses;
    for (int i = 0; i < opportunities.length; i++) {
      addresses
          .add(await _addressApi.getAddressById(opportunities[i].addressId));
    }
    return addresses;
  }

  //Get all badges from opportunities linked to a beacon
  Future<List<Badge>> getBadgesFromBeaconOpportunities(
      List<Opportunity> opportunities) async {
    List<Badge> badges = _badges == null ? new List<Badge>() : _badges;
    for (int i = 0; i < opportunities.length; i++) {
      badges.add(await _badgeApi.getBadgeById(opportunities[i].badgeId));
    }
    return badges;
  }

  //Get all issuers from opportunities linked to a beacon
  Future<List<Issuer>> getIssuersFromBeaconOpportunities(
      List<Opportunity> opportunities) async {
    List<Issuer> issuers = _issuers == null ? new List<Issuer>() : _issuers;
    for (int i = 0; i < opportunities.length; i++) {
      issuers.add(await _issuerApi.getIssuerById(opportunities[i].issuerId));
    }
    return issuers;
  }

  //API call to load an opportunity found by a beacon from the Firebase
  _loadFromFirebase(String major, String minor) async {
    final beacon = await _beaconApi.getBeaconById(major, minor);
    _notifiedKeyList.add(major + minor);
    final opportunities = await getBeaconOpportunitiesReady(beacon);
    final addresses = await getAddressesFromBeaconOpportunities(opportunities);
    final badges = await getBadgesFromBeaconOpportunities(opportunities);
    final issuers = await getIssuersFromBeaconOpportunities(opportunities);

    if (this.mounted) {
      setState(() {
        _beaconNumberOfOpp[major+minor] = beacon.opportunities.length;
        _opportunities = opportunities;
        _badges = badges;
        _issuers = issuers;
        _addresses = addresses;
      });
    }
  }

  //When clicking on a notification from a beacon, the app opens the opportunity details page
  //Of the opportunity of that beacon
  _navigateToOpportunityDetails(String payload) async {
    await LocalNotifications.removeNotification(int.parse(payload));

    Opportunity opportunity = _notIdOpportunity[int.parse(payload)];
    Badge badge = _badges.where((b) => b.openBadgeId == opportunity.badgeId).first;
    Issuer issuer = _issuers.where((i) => i.issuerId == opportunity.issuerId).first;
    Address address = _addresses.where((a) => a.addressId == opportunity.addressId).first;

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new OpportunityDetailsPage(
            opportunity,
            badge,
            issuer,
            address),
      ),
    );
  }

  //Scanning for beacons
  Future<Null> _beaconRanging() async {
    bool notified = false;
    int _notId = 0;
    Beacons.ranging(
      region: new BeaconRegionIBeacon(
        identifier: 'Gentlestudent beacons',
        //The ID all of our beacons share
        proximityUUID: 'B9407F30-F5F8-466E-AFF9-25556B57FE6D',
      ),
      inBackground: true,
    ).listen((result) async {
      if (result.isSuccessful) {
        if (result.beacons.isNotEmpty) {
          String beaconKey =
              result.beacons.first.ids[1] + result.beacons.first.ids[2];

          if (_keyList.contains(beaconKey) &&
              !_notifiedKeyList.contains(beaconKey)) {
            print(beaconKey);
            if (!notified) {
              await _loadFromFirebase(
                  result.beacons.first.ids[1], result.beacons.first.ids[2]);

              await LocalNotifications.createAndroidNotificationChannel(
                  channel: channel);

              for (int i = 0; i < _beaconNumberOfOpp[beaconKey]; i++) {
                Badge badge = _badges.where((b) => b.openBadgeId == _notIdOpportunity[_notId].badgeId).first;
                await LocalNotifications.createNotification(
                  title: "Beacon gevonden",
                  content: "Er is een leerkans in de buurt!",
                  id: _notId,
                  imageUrl: badge.image,
                  androidSettings: new AndroidSettings(
                    channel: channel,
                  ),
                  iOSSettings: new IOSSettings(
                    presentWhileAppOpen: true,
                  ),
                  onNotificationClick: new NotificationAction(
                    actionText: "some action",
                    callback: _navigateToOpportunityDetails,
                    payload: _notId.toString(),
                  ),
                );

                _notId++;
              }

              notified = true;
            }
          }
        } else {
          if (notified) {
            LocalNotifications.createAndroidNotificationChannel(
                channel: channel);
            LocalNotifications.createNotification(
                title: "Beacon buiten bereik",
                content: "De leerkans is niet langer in de buurt",
                id: _notId,
                androidSettings: new AndroidSettings(channel: channel));
          }

          notified = false;
          _notId++;
        }
      }
    });
  }
}
