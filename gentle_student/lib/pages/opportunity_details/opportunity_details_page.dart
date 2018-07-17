import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class OpportunityDetailsPage extends StatefulWidget {
  final Opportunity o;
  final Badge b;
  final Issuer i;
  final Address a;
  OpportunityDetailsPage(this.o, this.b, this.i, this.a);
  @override
  _OpportunityDetailsPageState createState() => _OpportunityDetailsPageState(o, b, i, a);
}

class _OpportunityDetailsPageState extends State<OpportunityDetailsPage> {
  Opportunity opportunity;
  Badge badge;
  Issuer issuer;
  Address address;
  ParticipationApi api;
  FirebaseUser firebaseUser;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  _OpportunityDetailsPageState(this.opportunity, this.badge, this.issuer, this.address);

  //Shows a given message at the bottom of the screen
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      duration: Duration(seconds: 4),
    ));
  }

  Future<Null> _displayAlertDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(opportunity.title),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(
                    'Bent u zeker dat u zich voor deze leerkans wilt inschrijven?'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ja'),
              onPressed: () {
                _enlistInOpportunity();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Neen'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _enlistInOpportunity() async {
    bool participationExists =
        await api.participationExists(firebaseUser, opportunity);
    if (participationExists) {
      _showSnackBar("U bent al ingeschreven voor deze leerkans.");
    } else {
      Map<String, dynamic> data = <String, dynamic>{
        "participantId": firebaseUser.uid,
        "opportunityId": opportunity.opportunityId,
        "status": 0,
        "reason": "",
      };
      final CollectionReference collection =
          Firestore.instance.collection("Participations");
      collection.add(data).whenComplete(() {
        print("Participation added");
      }).catchError((e) => print(e));
      _showSnackBar("U bent succesvol ingeschreven voor deze leerkans.");
    }
  }

  Widget buildStars(BuildContext context, int index) {
    return new Icon(
      Icons.star,
      color: Colors.yellow,
    );
  }

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      firebaseUser = user;
      final participationApi = new ParticipationApi();
      setState(() {
        api = participationApi;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doe mee!", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      key: scaffoldKey,
      body: ListView(
        children: <Widget>[
          //Top row
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: new Row(
              children: <Widget>[
                new Hero(
                  child: new CircleAvatar(
                    backgroundImage:
                        new NetworkImage(badge.image),
                    radius: 32.0,
                  ),
                  tag: "badge image",
                ),
                new Expanded(
                  child: new Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 24.0),
                    child: new Text(
                      opportunity.title,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black54,
                          fontSize: 21.0),
                    ),
                  ),
                ),
                new Row(
                  children: new List.generate(opportunity.difficulty.index + 1,
                      (index) => buildStars(context, index)),
                ),
              ],
            ),
          ),

          //Big image
          new Image.network(opportunity.opportunityImageUrl),

          //Blue box
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 16.0,
              bottom: 8.0,
            ),
            child: new Container(
              padding: EdgeInsets.all(14.0),
              decoration: new BoxDecoration(
                border: new Border.all(color: Colors.lightBlue),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //Category
                  new Text(
                    _getCategory(opportunity),
                    style: new TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 14.0,
                      color: Colors.lightBlue,
                    ),
                  ),
                  new SizedBox(
                    height: 6.0,
                  ),

                  //Period
                  new Row(
                    children: <Widget>[
                      new Text(
                        "Periode:",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                          " van " +
                              _makeDate(opportunity.beginDate) +
                              " tot " +
                              _makeDate(opportunity.endDate),
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 6.0,
                  ),

                  //Place
                  new Row(
                    children: <Widget>[
                      new Text(
                        "Plaats:",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                          " " +
                              address.street +
                              " " +
                              address.housenumber.toString() +
                              " " +
                              address.bus +
                              ", " +
                              address.postalcode.toString() +
                              " " +
                              address.city,
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 6.0,
                  ),

                  //Issuer
                  new Row(
                    children: <Widget>[
                      new Text(
                        "Issuer:",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                          " " + issuer.name,
                          style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.lightBlue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          //Short description
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 16.0,
              bottom: 8.0,
            ),
            child: new Text(
              opportunity.shortDescription,
              style: new TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          //Long description
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 8.0,
              bottom: 10.0,
            ),
            child: new Text(
              opportunity.longDescription,
              style: new TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),

          //Button
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 10.0,
              bottom: 16.0,
            ),
            child: Material(
              borderRadius: BorderRadius.circular(10.0),
              shadowColor: Colors.lightBlueAccent.shade100,
              elevation: 5.0,
              child: MaterialButton(
                minWidth: 200.0,
                height: 42.0,
                onPressed: () => _displayAlertDialog(),
                color: Colors.lightBlueAccent,
                child: Text('Doe mee!', style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _makeDate(DateTime date) {
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
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
