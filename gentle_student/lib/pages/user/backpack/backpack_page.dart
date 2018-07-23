import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/assertion.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BackPackPage extends StatefulWidget {
  static String tag = 'backpack-page';
  @override
  _BackPackPageState createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  FirebaseUser firebaseUser;
  List<Assertion> _assertions = [];
  List<Badge> _badges = [];
  List<Issuer> _issuers = [];
  List<Opportunity> _opportunities = [];

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      firebaseUser = user;
      _loadFromFirebase();
    });
  }

  _loadFromFirebase() async {
    final assertionApi = new AssertionApi();
    final badgeApi = new BadgeApi();
    final issuerApi = new IssuerApi();
    final opportunityApi = new OpportunityApi();
    final assertions =
        await assertionApi.getAllAssertionsFromUser(firebaseUser.uid);
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
                  style: TextStyle(
                    fontSize: 15.0,
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
                  title: new Text(
                    opportunity.title,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                        fontSize: 16.0),
                  ),
                  subtitle: new Text(
                    _getCategory(opportunity) +
                        "\n" +
                        _getDifficulty(opportunity) +
                        "\n" +
                        issuer.name,
                    style: new TextStyle(fontSize: 12.0),
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
                  child: new Text(
                    "U heeft deze badge behaald op " +
                        _makeDate(assertion.issuedOn) +
                        ".",
                    textAlign: TextAlign.center,
                    style: new TextStyle(fontSize: 14.0),
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
      backgroundColor: Colors.white,
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

  static String _makeDate(DateTime date) {
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
  }

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
