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

class HomePage extends StatefulWidget {
  static String tag = 'home-page';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 1;
  InformationPage informationPage = new InformationPage();
  MapListPage mapListPage = new MapListPage();
  UserPage userPage = new UserPage();
  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    super.initState();
    _loadBeacons();
    _beaconRanging();
    pages = [informationPage, mapListPage, userPage];
    currentPage = mapListPage;
  }

  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar navBar = new BottomNavigationBar(
      fixedColor: Colors.lightBlue,
      currentIndex: currentTab,
      onTap: (int numTab) {
        setState(() {
          currentTab = numTab;
          currentPage = pages[numTab];
        });
      },
      items: <BottomNavigationBarItem>[
        new BottomNavigationBarItem(
          icon: new Icon(Icons.info),
          title: new Text(
            "Informatie",
          ),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.location_on),
          title: new Text(
            "Leerkansen",
          ),
        ),
        new BottomNavigationBarItem(
          icon: new Icon(Icons.account_circle),
          title: new Text(
            "Gebruiker",
          ),
        )
      ],
    );

    return new Scaffold(
      bottomNavigationBar: navBar,
      body: currentPage,
    );
  }

  static const AndroidNotificationChannel channel =
      const AndroidNotificationChannel(
          id: 'default_notification',
          name: 'Default',
          description: 'Grant this app the ability to show notifications',
          importance: AndroidNotificationChannelImportance.DEFAULT);

  List<String> _keyList = [];
  Set<String> _notifiedKeyList = new Set<String>();
  BeaconApi _beaconApi;
  OpportunityApi _opportunityApi;
  BadgeApi _badgeApi;
  IssuerApi _issuerApi;
  AddressApi _addressApi;
  List<Opportunity> _opportunities = [];
  List<Badge> _badges = [];
  List<Issuer> _issuers = [];
  List<Address> _addresses = [];
  HashMap<int, Opportunity> _notIdOpportunity = new HashMap();

  Future<Null> _loadBeacons() async {
    final beaconApi = new BeaconApi();
    final beacons = await beaconApi.getAllBeacons();
    final keyList = new List<String>();
    beacons.forEach((beacon) => keyList.add(beacon.major + beacon.minor));
    final opportunityApi = new OpportunityApi();
    final badgeApi = new BadgeApi();
    final issuerApi = new IssuerApi();
    final addressApi = new AddressApi();
    if (this.mounted) {
      setState(() {
        _beaconApi = beaconApi;
        _keyList = keyList;
        _opportunityApi = opportunityApi;
        _badgeApi = badgeApi;
        _issuerApi = issuerApi;
        _addressApi = addressApi;
      });
    }
  }

  Future<Null> _getOpportunitiesFromBeacon(IBeacon beacon) async {
    Opportunity opportunity;
    for (int i = 0; i < beacon.opportunities.length; i++) {
      opportunity = await _opportunityApi
          .getOpportunityById(beacon.opportunities.keys.toList()[i]);
      _opportunities.add(opportunity);
      _badges.add(await _badgeApi.getBadgeById(opportunity.badgeId));
      _issuers.add(await _issuerApi.getIssuerById(opportunity.issuerId));
      _addresses.add(await _addressApi.getAddressById(opportunity.addressId));
    }
  }

  Future<Null> _navigateToOpportunityDetails(String payload) async {
    await LocalNotifications.removeNotification(int.parse(payload));

    Opportunity opportunity = _notIdOpportunity[int.parse(payload)];
    Badge badge =
        _badges.where((b) => b.openBadgeId == opportunity.badgeId).first;
    Issuer issuer =
        _issuers.where((i) => i.issuerId == opportunity.issuerId).first;
    Address address =
        _addresses.where((a) => a.addressId == opportunity.addressId).first;

    Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) =>
            new OpportunityDetailsPage(opportunity, badge, issuer, address),
      ),
    );
  }

  Future<Null> _beaconRanging() async {
    int _notificationId = 0;
    bool notified = false;
    IBeacon beacon;
    Beacons.ranging(
      region: new BeaconRegionIBeacon(
        identifier: 'Gentlestudent beacons',
        proximityUUID: 'B9407F30-F5F8-466E-AFF9-25556B57FE6D',
      ),
      inBackground: true,
    ).listen((result) async {
      if (result.isSuccessful) {
        if (result.beacons.isNotEmpty) {
          String beaconKey =
              result.beacons.first.ids[1] + result.beacons.first.ids[2];
          print("Found a beacon: $beaconKey");
          if (_keyList.contains(beaconKey) &&
              !_notifiedKeyList.contains(beaconKey)) {
            print("Beacon $beaconKey was found in the database!");
            _notifiedKeyList.add(beaconKey);
              beacon = await _beaconApi.getBeaconById(
                  result.beacons.first.ids[1], result.beacons.first.ids[2]);
              await _getOpportunitiesFromBeacon(beacon);

              await LocalNotifications.createAndroidNotificationChannel(
                  channel: channel);

              for (int i = 0; i < beacon.opportunities.length; i++) {
                Opportunity opportunity = _opportunities.firstWhere((o) =>
                    o.opportunityId == beacon.opportunities.keys.toList()[i]);
                Badge badge = _badges
                    .firstWhere((b) => b.openBadgeId == opportunity.badgeId);
                await LocalNotifications.createNotification(
                  title: "Beacon gevonden",
                  content: "Er is een leerkans in de buurt!",
                  id: _notificationId,
                  imageUrl: badge.image,
                  androidSettings: new AndroidSettings(
                    channel: channel,
                  ),
                  iOSSettings: new IOSSettings(
                    presentWhileAppOpen: true,
                  ),
                  onNotificationClick: new NotificationAction(
                    actionText: "Navigate to opportunity details",
                    callback: _navigateToOpportunityDetails,
                    payload: _notificationId.toString(),
                  ),
                );

                _notIdOpportunity[_notificationId] = opportunity;
                _notificationId++;
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
                id: _notificationId,
                androidSettings: new AndroidSettings(channel: channel));
            _notificationId++;
            notified = false;
          }
        }
      }
    });
  }
}
