import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/assertion.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

//This page contains all badges of a user
class BackPackPage extends StatefulWidget {
  //This tag allows us to navigate to the BackpackPage
  static String tag = 'backpack-page';

  @override
  _BackPackPageState createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  //Declaration of the variables
  List<Assertion> _assertions = [];
  List<Badge> _badges = [];
  List<Issuer> _issuers = [];
  List<Opportunity> _opportunities = [];

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load the Firebase user
  // - Load data from the Firebase
  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

  //API call to get data from the Firebase
  _loadFromFirebase() async {
    final assertionApi = new AssertionApi();
    final badgeApi = new BadgeApi();
    final issuerApi = new IssuerApi();
    final opportunityApi = new OpportunityApi();
    final assertions = await assertionApi
        .getAllAssertionsFromUser((await FirebaseUtils.firebaseUser).uid);
    final badges = await badgeApi.getAllBadges();
    final issuers = await issuerApi.getAllIssuers();
    final opportunities = await opportunityApi.getAllOpportunities();
    if (this.mounted) {
      setState(() {
        _assertions = assertions;
        _badges = badges;
        _issuers = issuers;
        _opportunities = opportunities;
      });
    }
  }

  //Building an assertion (= badge of a user)
  Widget _buildAssertionItem(BuildContext context, int index) {
    Assertion assertion = _assertions[index];
    Badge badge =
        _badges.firstWhere((b) => b.openBadgeId == assertion.openBadgeId);
    Opportunity opportunity =
        _opportunities.firstWhere((o) => o.badgeId == badge.openBadgeId);
    Issuer issuer =
        _issuers.firstWhere((i) => i.issuerId == opportunity.issuerId);

    return new Center(
      child: GestureDetector(
        onTap: () =>
            _displayAssertionDetails(assertion, opportunity, badge, issuer),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Hero(
              tag: "assertion " + index.toString(),
              child: new CircleAvatar(
                child: new Image(
                  image: new CachedNetworkImageProvider(badge.image),
                ),
                radius: 38.0,
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(
                  issuer.institution,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //Function for launching an url into a browser of a smartphone
  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Download the badge with the included metadata
  void _downloadBadge() {
    _launchInBrowser("https://gentlestudent.gent/backpack");
  }

  Text _assertionCreatedDate(DateTime issuedOn) {
    if (DateTime.parse("2000-01-01") == issuedOn) {
      return Text(
        "De issuer van deze leerkans heeft de badge nog niet aan u toegekend.",
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 14.0),
      );
    } else {
      return Text(
        "U heeft deze badge behaald op " + _makeDate(issuedOn) + ".",
        textAlign: TextAlign.center,
        style: new TextStyle(fontSize: 14.0),
      );
    }
  }

  //Displays a message with details of the pressed assertion
  Future<Null> _displayAssertionDetails(Assertion assertion,
      Opportunity opportunity, Badge badge, Issuer issuer) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          contentPadding: EdgeInsets.all(0.0),
          content: new Padding(
            padding: EdgeInsets.only(
              top: 5.0,
              bottom: 5.0,
            ),
            child: new Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new ListTile(
                  contentPadding: EdgeInsets.only(left: 6.0),
                  leading: new Hero(
                    tag: "assertion image",
                    child: new CircleAvatar(
                      child: new Image(
                        image: new CachedNetworkImageProvider(badge.image),
                      ),
                      radius: 28.0,
                    ),
                  ),
                  title: new Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: new Text(
                      opportunity.title,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black54,
                          fontSize: 16.0),
                    ),
                  ),
                  subtitle: new Padding(
                    padding: EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 5.0,
                      bottom: 5.0,
                    ),
                    child: new Text(
                      _getCategory(opportunity) +
                          "\n" +
                          _getDifficulty(opportunity) +
                          "\n" +
                          issuer.name,
                      style: new TextStyle(fontSize: 12.0),
                    ),
                  ),
                  isThreeLine: true,
                  dense: false,
                ),
                new Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 5.0,
                    bottom: 5.0,
                  ),
                  child: _assertionCreatedDate(assertion.issuedOn),
                ),
                new Padding(
                  padding: EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                    top: 15.0,
                    bottom: 20.0,
                  ),
                  child: Material(
                    borderRadius: BorderRadius.circular(10.0),
                    shadowColor: Colors.lightBlueAccent.shade100,
                    child: MaterialButton(
                      minWidth: 200.0,
                      height: 36.0,
                      onPressed: () {
                        Navigator.of(context).pop();
                        _downloadBadge();
                      },
                      color: Colors.lightBlueAccent,
                      child: Text('Bekijk op het web',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Backpack", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(5.0, 15.0, 5.0, 0.0),
        child: new GridView.builder(
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: _assertions.length,
          itemBuilder: _buildAssertionItem,
        ),
      ),
    );
  }

  //Formatting the date to be more readable
  static String _makeDate(DateTime date) {
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
  }

  //Function to get the name of a difficulty in String form
  static String _getDifficulty(Opportunity opportunity) {
    switch (opportunity.difficulty) {
      case Difficulty.BEGINNER:
        return "Niveau 1";
      case Difficulty.INTERMEDIATE:
        return "Niveau 2";
      case Difficulty.EXPERT:
        return "Niveau 3";
    }
    return "Niveau 0";
  }

  //Function to get the name of a category in String form
  static String _getCategory(Opportunity opportunity) {
    switch (opportunity.category) {
      case Category.DIGITALEGELETTERDHEID:
        return "Digitale geletterdheid";
      case Category.DUURZAAMHEID:
        return "Duurzaamheid";
      case Category.ONDERNEMINGSZIN:
        return "Ondernemingszin";
      case Category.ONDERZOEK:
        return "Onderzoek";
      case Category.WERELDBURGERSCHAP:
        return "Wereldburgerschap";
    }
    return "Algemeen";
  }
}
