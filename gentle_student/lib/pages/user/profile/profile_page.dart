import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static String tag = 'profile-page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  FirebaseUser firebaseUser;
  Participant _participant = new Participant(
      name: "",
      institute: "",
      participantId: "0",
      email: "",
      birthdate: DateTime.now(),
      education: "",
      profilePicture: "");

  @override
  void initState() {
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      firebaseUser = user;
      _loadFromFirebase();
    });
    super.initState();
  }

  _loadFromFirebase() async {
    final participantApi = new ParticipantApi();
    final participant =
        await participantApi.getParticipantById(firebaseUser.uid);
    if (this.mounted) {
      setState(() {
        _participant = participant;
      });
    }
  }

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    final logo = Hero(
      tag: 'profile hero logo',
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 60.0,
        child: Icon(
          Icons.account_circle,
          size: 120.0,
        ),
      ),
    );

    final profilePicture = Hero(
      tag: 'profile hero picture',
      child: CircleAvatar(
        radius: 60.0,
        child: Image(
          image: CachedNetworkImageProvider(_participant.profilePicture),
          width: 120.0,
          height: 120.0,
        ),
      ),
    );

    final profilePicture3 = Container(
      constraints: BoxConstraints(
        maxHeight: 120.0,
        maxWidth: 120.0,
      ),
      child: CircleAvatar(
        radius: 60.0,
        child: Image(
          image: CachedNetworkImageProvider(_participant.profilePicture),
          width: 120.0,
          height: 120.0,
        ),
      ),
    );

    final profilePicture2 = Container(
      width: 120.0,
      height: 120.0,
      decoration: new BoxDecoration(
        color: const Color(0xff7c94b6),
        image: new DecorationImage(
          image: CachedNetworkImageProvider(_participant.profilePicture),
          fit: BoxFit.cover,
        ),
        borderRadius: new BorderRadius.all(new Radius.circular(50.0)),
        border: new Border.all(
          color: Colors.red,
          width: 4.0,
        ),
      ),
    );

    Widget _logoOrProfilePicture() {
      if (_participant.profilePicture == "")
        return logo;
      else
        return profilePicture2;
    }

    final name = Text(
      _participant.name,
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24.0,
      ),
    );

    final lblMail = Text(
      'E-mailadres:',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontSize: 16.0,
      ),
    );

    final lblEducation = Text(
      'Richting:',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontSize: 16.0,
      ),
    );

    final lblInstitute = Text(
      'Onderwijsinstelling:',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontSize: 16.0,
      ),
    );

    final lblBirthdate = Text(
      'Geboortedatum:',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontSize: 16.0,
      ),
    );

    final mail = Text(
      _participant.email,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    final education = Text(
      _participant.education,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    final institute = Text(
      _participant.institute,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    final birthdate = Text(
      _makeDate(_participant.birthdate),
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "Profiel",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
            ),
            onPressed: () => _launchInBrowser("http://gentlestudent.gent"),
            tooltip: "Klik hier om uw gegevens aan te kunnen passen",
          ),
        ],
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new Container(
        color: color,
        height: 300.0,
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 24.0),
            _logoOrProfilePicture(),
            SizedBox(height: 24.0),
            name,
            Container(
              margin: EdgeInsets.only(left: 24.0, right: 24.0, top: 20.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5.0),
                boxShadow: <BoxShadow>[
                  new BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: new Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(bottom: 24.0),
                children: <Widget>[
                  SizedBox(height: 30.0),
                  lblMail,
                  SizedBox(height: 5.0),
                  mail,
                  SizedBox(height: 30.0),
                  lblBirthdate,
                  SizedBox(height: 5.0),
                  birthdate,
                  SizedBox(height: 30.0),
                  lblInstitute,
                  SizedBox(height: 5.0),
                  institute,
                  SizedBox(height: 30.0),
                  lblEducation,
                  SizedBox(height: 5.0),
                  education,
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  static String _makeDate(DateTime date) {
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
  }
}
