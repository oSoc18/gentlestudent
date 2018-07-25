import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

//On this page users can view their profile
class ProfilePage extends StatefulWidget {
  //This tag allows us to navigate to the ProfilePage
  static String tag = 'profile-page';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  //Declaration of the variables
  FirebaseUser firebaseUser;
  Participant _participant = new Participant(
      name: "",
      institute: "",
      participantId: "0",
      email: "",
      birthdate: DateTime.now(),
      education: "",
      profilePicture: "",
      favorites: new List<String>());

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load the Firebase user
  // - Load data from the Firebase
  @override
  void initState() {
    FirebaseAuth.instance.onAuthStateChanged.listen((user) {
      firebaseUser = user;
      _loadFromFirebase();
    });
    super.initState();
  }

  //API call to load data from the Firebase
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

  //Function for launching an url into a browser of a smartphone
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

    //Logo, if the user doesn't have a profile picture yey
    final logo = Center(
      child: Hero(
        tag: 'profile hero logo',
        child: CircleAvatar(
          backgroundColor: Colors.white,
          radius: 75.0,
          child: Icon(
            Icons.account_circle,
            size: 150.0,
          ),
        ),
      ),
    );

    //ProfilePicture, if the user has one
    final profilePicture = Center(
      child: Container(
        width: 150.0,
        height: 150.0,
        decoration: new BoxDecoration(
          color: const Color(0xff7c94b6),
          image: new DecorationImage(
            image: CachedNetworkImageProvider(_participant.profilePicture),
            fit: BoxFit.cover,
          ),
          borderRadius: new BorderRadius.all(new Radius.circular(360.0)),
          border: new Border.all(
            color: Colors.white,
            width: 3.0,
          ),
        ),
      ),
    );

    //Checking whether to use the logo or the profile
    Widget _logoOrProfilePicture() {
      if (_participant.profilePicture == "")
        return logo;
      else
        return profilePicture;
    }

    //Name of the user
    final name = Text(
      _participant.name,
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24.0,
      ),
    );

    //Mail label
    final lblMail = Text(
      'E-mailadres:',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontSize: 16.0,
      ),
    );

    //Education label
    final lblEducation = Text(
      'Richting:',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontSize: 16.0,
      ),
    );

    //Institute label
    final lblInstitute = Text(
      'Onderwijsinstelling:',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontSize: 16.0,
      ),
    );

    //Birthdate label
    final lblBirthdate = Text(
      'Geboortedatum:',
      textAlign: TextAlign.center,
      style: new TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black45,
        fontSize: 16.0,
      ),
    );

    //Email of the user
    final mail = Text(
      _participant.email,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    //Education of the user
    final education = Text(
      _participant.education,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    //Institute of the user
    final institute = Text(
      _participant.institute,
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    //Birthdate of the user
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
        //App icon that looks like a pencil
        //When click, the browser will open the website
        //Where they can change their profile
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            
            //Logo or ProfilePicture and Name of the user
            Container(
              color: color,
              height: 240.0,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 24.0),
                  _logoOrProfilePicture(),
                  SizedBox(height: 24.0),
                  name,
                ],
              ),
            ),

            //Other information of the user
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
            ),
          ],
        ),
      ),
    );
  }

  static String _makeDate(DateTime date) {
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
  }
}
