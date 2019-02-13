import 'dart:async';
import 'package:Gentle_Student/models/address.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/models/participant.dart';
import 'package:Gentle_Student/models/participation.dart';
import 'package:Gentle_Student/models/status.dart';
import 'package:Gentle_Student/models/issuer.dart';
import 'package:Gentle_Student/network/api.dart';
import 'package:Gentle_Student/utils/email_helper.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

//This page show all the details of an opportunity
class OpportunityDetailsPage extends StatefulWidget {
  //We need these objects to render this page
  final Opportunity o;
  final Badge b;
  final Issuer i;
  final Address a;

  //We pass the object to the constructor of this page
  OpportunityDetailsPage(this.o, this.b, this.i, this.a);

  //We pass the objects to the state page
  @override
  _OpportunityDetailsPageState createState() =>
      _OpportunityDetailsPageState(o, b, i, a);
}

class _OpportunityDetailsPageState extends State<OpportunityDetailsPage> {
  //Declaration of the variables
  Opportunity opportunity;
  Badge badge;
  Issuer issuer;
  Address address;
  Participation _participation = new Participation(
      opportunityId: "0",
      participantId: "0",
      participationId: "0",
      reason: "0",
      status: Status.REFUSED);
  ParticipationApi _participationApi;
  Participant _participant;
  ParticipantApi _participantApi;
  OpportunityApi _opportunityApi;
  bool _alreadyRegistered = false;
  TextEditingController controller;
  Icon heart = Icon(
    Icons.favorite_border,
    color: Colors.red,
  );
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  //Constructor
  _OpportunityDetailsPageState(
      this.opportunity, this.badge, this.issuer, this.address) {
    controller = new TextEditingController();
  }

  //Shows a given message at the bottom of the screen
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      duration: Duration(seconds: 4),
    ));
  }

  //Displays a message which asks the user if they want to enlist
  //In the opportunity
  Future<Null> _displayRegistrationAlertDialog() async {
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
                    'Bent u zeker dat u zich voor deze leerkans wilt registreren?'),
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

  //Function to create an assertion
  //When the user claims a badge
  _claimBadgeCreateAssertion() async {
    Map<String, dynamic> data = <String, dynamic>{
      "badgeId": badge.openBadgeId,
      "issuedOn": "2000-01-01",
      "recipientId": (await FirebaseUtils.firebaseUser).uid,
    };
    final CollectionReference collection =
        Firestore.instance.collection("Assertions");
    collection.add(data).whenComplete(() {
      print("Assertion added");
    }).catchError((e) => print(e));
  }

  //Displays a message when a user wants to claim a beginner's badge
  Future<Null> _displayClaimAlertDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Badge claimen"),
          content: new SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: new ListBody(
              children: <Widget>[
                new Text(
                    'Waarom denk jij in aanmerking te komen om deze badge te claimen? Laat het hieronder weten.'),
                SizedBox(
                  height: 8.0,
                ),
                new TextField(
                  controller: controller,
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: 6,
                )
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Claim badge'),
              onPressed: () async {
                if (controller.text != "" && controller.text != null) {
                  //Status of the participation goes to accepted
                  //Message of the participations becomes whatever the user filled into the textfield
                  await _participationApi.updateParticipationAfterBadgeClaim(
                      _participation, controller.text);

                  //The badge gets added to the backpack of the user
                  await _claimBadgeCreateAssertion();

                  _showSnackBar(
                      "U heeft de badge succesvol geclaimd! Hij is nu zichtbaar in uw backpack.");

                  setState(() {
                    _participation = new Participation(
                        opportunityId: "0",
                        participantId: "0",
                        participationId: "0",
                        reason: "0",
                        status: Status.REFUSED);
                  });
                } else {
                  _showSnackBar(
                      "U moet een boodschap meegeven om de badge te kunnen claimen.");
                }
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Annuleer'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Function to check whether the current user has
  //already been registered for the opportunity
  Future<Null> _hasAlreadyBeenRegistered() async {
    bool value = await _participationApi.participationExists(
        await FirebaseUtils.firebaseUser, opportunity);
    setState(() {
      _alreadyRegistered = value;
    });
    if (_alreadyRegistered) {
      Participation participation =
          await _participationApi.getParticipantByUserAndOpportunity(
              await FirebaseUtils.firebaseUser, opportunity);
      setState(() {
        _participation = participation;
      });
    }
  }

  //Function to create a participation
  //It enlists the participant in an opportunity
  _enlistInOpportunity() async {
    bool participationExists = _alreadyRegistered;
    if (participationExists) {
      _showSnackBar("U bent al geregistreerd voor deze leerkans.");
    } else {
      Map<String, dynamic> data = <String, dynamic>{
        "participantId": (await FirebaseUtils.firebaseUser).uid,
        "opportunityId": opportunity.opportunityId,
        "status": 0,
        "reason": "",
        "message": "",
      };
      final CollectionReference collection =
          Firestore.instance.collection("Participations");
      collection.add(data).whenComplete(() {
        _opportunityApi.updateOpportunityAfterParticipationCreation(
            opportunity, opportunity.participations);
        print("Participation added");
      }).catchError((e) => print(e));
      setState(() {
        _alreadyRegistered = true;
      });
      _showSnackBar("U bent succesvol geregistreerd voor deze leerkans.");

      await _sendMailToIssuer();
    }
  }

  //Sends a mail to an issuer when a participant is registered for the opportunity
  _sendMailToIssuer() async {
    ParticipantApi participantApi = new ParticipantApi();
    Participant participant = await participantApi
        .getParticipantById((await FirebaseUtils.firebaseUser).uid);
    new EmailHelper(issuer, participant, opportunity);
  }

  //Function to check whether the current user has already favorited this opportunity
  _checkIfUserAlreadyFavorited() async {
    _participant = await _participantApi
        .getParticipantById((await FirebaseUtils.firebaseUser).uid);
    if (_participant.favorites.contains(opportunity.opportunityId)) {
      setState(() {
        heart = Icon(
          Icons.favorite,
          color: Colors.red,
        );
      });
    }
  }

  //Change the status from favorited to unfavorited or the other way around
  _favoriteOrUnfavorite() async {
    if (_participant.favorites.contains(opportunity.opportunityId)) {
      _participant.favorites.remove(opportunity.opportunityId);
      await _participantApi.changeFavorites(
          (await FirebaseUtils.firebaseUser).uid, _participant.favorites);
      setState(() {
        heart = Icon(
          Icons.favorite_border,
          color: Colors.red,
        );
      });
    } else {
      _participant.favorites.add(opportunity.opportunityId);
      await _participantApi.changeFavorites(
          (await FirebaseUtils.firebaseUser).uid, _participant.favorites);
      setState(() {
        heart = Icon(
          Icons.favorite,
          color: Colors.red,
        );
      });
    }
  }

  void _hasAlreadyClaimedBadge() {
    if (_participation != null)
      _displayClaimAlertDialog();
    else
      _showSnackBar(
          "U heeft deze badge al geclaimd. Ga naar de backpack om hem te bekijken.");
  }

  //Build the stars displayed at the top of the page to indicate the difficulty of the opportunity
  Widget buildStars(BuildContext context, int index) {
    return new Icon(
      Icons.star,
      color: Colors.yellow,
    );
  }

  Padding _showButton() {
    if (_alreadyRegistered &&
        opportunity.difficulty == Difficulty.BEGINNER &&
        _participation.status == Status.PENDING) {
      return Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 10.0,
          bottom: 16.0,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () => _hasAlreadyClaimedBadge(),
            color: Colors.lightBlueAccent,
            child: Text('Claim badge', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(
          left: 20.0,
          right: 20.0,
          top: 10.0,
          bottom: 16.0,
        ),
        child: Material(
          borderRadius: BorderRadius.circular(10.0),
          shadowColor: Colors.lightBlueAccent.shade100,
          child: MaterialButton(
            minWidth: 200.0,
            height: 42.0,
            onPressed: () => _displayRegistrationAlertDialog(),
            color: Colors.lightBlueAccent,
            child: Text('Registreer', style: TextStyle(color: Colors.white)),
          ),
        ),
      );
    }
  }

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load the Firebase user
  // - Load data from the Firebase
  @override
  void initState() {
    super.initState();
    final participationApi = new ParticipationApi();
    final participantApi = new ParticipantApi();
    final opportunityApi = new OpportunityApi();
    if (this.mounted) {
      setState(() {
        _participationApi = participationApi;
        _participantApi = participantApi;
        _opportunityApi = opportunityApi;
      });
      _checkIfUserAlreadyFavorited();
      _hasAlreadyBeenRegistered();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registreren", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      key: scaffoldKey,
      body: ListView(
        children: <Widget>[
          //Top row of the page
          new Padding(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
              top: 8.0,
              bottom: 8.0,
            ),
            child: new Row(
              children: <Widget>[
                //Badge icon
                new Hero(
                  child: new CircleAvatar(
                    child: new Image(
                      image: new CachedNetworkImageProvider(badge.image),
                    ),
                    radius: 32.0,
                  ),
                  tag: "badge image",
                ),

                //Opportunity title
                new Expanded(
                  child: new Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 24.0),
                    child: new Text(
                      opportunity.title,
                      style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.black54,
                          fontSize: 20.0),
                    ),
                  ),
                ),

                //Stars
                new Row(
                  children: new List.generate(opportunity.difficulty.index + 1,
                      (index) => buildStars(context, index)),
                ),

                //Heart icon
                new IconButton(
                  onPressed: () => _favoriteOrUnfavorite(),
                  icon: heart,
                )
              ],
            ),
          ),

          //Big image
          new CachedNetworkImage(
            imageUrl: opportunity.opportunityImageUrl,
            placeholder: new CircularProgressIndicator(),
            errorWidget: new Icon(Icons.error),
          ),

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
                  new SizedBox(
                    height: 6.0,
                  ),

                  //Contact
                  new Row(
                    children: <Widget>[
                      new Text(
                        "Contact:",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                          " " + opportunity.contact,
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

                  //Website
                  new Row(
                    children: <Widget>[
                      new Text(
                        "Website:",
                        style: new TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.lightBlue,
                        ),
                      ),
                      new Expanded(
                        child: new Text(
                          " " + opportunity.website,
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
          _showButton(),
        ],
      ),
    );
  }

  //Function for formatting the date to make it more readable
  static String _makeDate(DateTime date) {
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
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
