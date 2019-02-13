import 'dart:async';

import 'package:Gentle_Student/models/participant.dart';
import 'package:Gentle_Student/network/network_api.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:Gentle_Student/views/pages/user/profile/edit_profile_page.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  Participant _participant = new Participant(
      name: "",
      institute: "",
      participantId: "0",
      email: "",
      profilePicture: "",
      favorites: new List<String>());

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load the Firebase user
  // - Load data from the Firebase
  @override
  void initState() {
    _loadFromFirebase();
    super.initState();
  }

  //API call to load data from the Firebase
  _loadFromFirebase() async {
    final participantApi = new ParticipantApi();
    final participant =
        await participantApi.getParticipantById((await FirebaseUtils.firebaseUser).uid);
    if (this.mounted) {
      setState(() {
        _participant = participant;
      });
    }
  }

  //Change profile settings in the Firebase
  Future<Null> _changeProfileSettings(String institute, String name) async {
    Map<String, String> data = <String, String>{
      "institute": institute,
      "name": name,
    };
    await Firestore.instance
        .collection("Participants")
        .document((await FirebaseUtils.firebaseUser).uid)
        .updateData(data)
        .whenComplete(() {
      print("Participant updated");
    }).catchError((e) => print(e));

    UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
    userUpdateInfo.displayName = name;
    await FirebaseAuth.instance.updateProfile(userUpdateInfo);

    await _loadFromFirebase();
  }

  //Opening the editing profile page
  Future _openEditProfilePageDialog() async {
    List<String> settings = await Navigator.of(context).push(
      new MaterialPageRoute<List<String>>(
        builder: (BuildContext context) {
          return new EditProfilePage(_participant.name, _participant.institute);
        },
        fullscreenDialog: true,
      ),
    );
    if (settings != null) {
      _showAlertDialog(settings[0], settings[1]);
    }
  }

  //Dialog containing the privacy policy for GDPR reasons
  Future<Null> _showAlertDialog(String name, String institute) async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Gegevens wijzigen"),
          content: Text(
            'U staat op het punt om uw gegevens te wijzigen. Bent u zeker dat u dit wilt doen?',
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Akkoord'),
              onPressed: () async {
                await _changeProfileSettings(institute, name);
                await _loadFromFirebase();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('Niet akkoord'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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

    //Email of the user
    final mail = Text(
      _participant.email,
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
            onPressed: () => _openEditProfilePageDialog(),
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
                  lblInstitute,
                  SizedBox(height: 5.0),
                  institute,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
