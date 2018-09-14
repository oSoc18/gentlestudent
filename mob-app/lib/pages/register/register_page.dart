import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseUser, UserUpdateInfo;
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

//This page handles everything that's related to creating an account
class RegisterPage extends StatefulWidget {
  //This tag allows us to navigate to the RegisterPage
  static String tag = 'register-page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Declaration of the variables
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseUser firebaseUser;
  var firstnameController;
  var lastnameController;
  var instituteController;
  var emailController;
  var passwordController;
  var repeatPasswordController;

  //Constructor
  _RegisterPageState() {
    firstnameController = new TextEditingController();
    lastnameController = new TextEditingController();
    instituteController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    repeatPasswordController = new TextEditingController();
  }

  //Function for launching an url into a browser of a smartphone
  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  //Create account with Firebase
  void _register() async {
    try {
      firebaseUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
      userUpdateInfo.displayName = firstnameController.text + " " + lastnameController.text;
      await FirebaseAuth.instance.updateProfile(userUpdateInfo);
      await firebaseUser.sendEmailVerification();
      _addUserToDatabase();
      Navigator.of(context).pop();
    } catch (Error) {
      _showSnackBar("Er is iets fout gelopen tijdens het registeren.");
    }
  }

  //Add user details (participant document) to Firebase
  void _addUserToDatabase() {
    Map<String, dynamic> data = <String, dynamic>{
      "name": firstnameController.text + " " + lastnameController.text,
      "institute": instituteController.text,
      "email": emailController.text,
      "profilePicture": "",
      "favorites": new List<String>(),
    };
    final DocumentReference documentReference =
        Firestore.instance.document("Participants/" + firebaseUser.uid);
    documentReference.setData(data).whenComplete(() {
      print("User added");
    }).catchError((e) => print(e));
  }

  //Custom form validation to check if all fields are filled in
  bool _allFieldsFilledIn() {
    return firstnameController.text != null &&
        firstnameController.text != "" &&
        lastnameController.text != null &&
        lastnameController.text != "" &&
        instituteController.text != null &&
        instituteController.text != "" &&
        emailController.text != null &&
        emailController.text != "" &&
        passwordController.text != null &&
        passwordController.text != "" &&
        repeatPasswordController.text != null &&
        repeatPasswordController.text != "";
  }

  //Dialog containing the privacy policy for GDPR reasons
  Future<Null> _displayGDPRDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Privacybeleid & voorwaarden"),
          content: new RichText(
            textAlign: TextAlign.justify,
            text: new TextSpan(
              children: [
                new TextSpan(
                  text:
                      'Door hieronder op de knop "Akkoord" te drukken, bevestigt u dat u de ',
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                ),
                new TextSpan(
                  text: 'privacy policy van Gentlestudent',
                  style: new TextStyle(color: Colors.blue),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () async {
                      await _launchInBrowser(
                          "https://gentlestudent.gent/privacy");
                    },
                ),
                new TextSpan(
                  text: ' gelezen heeft en er tevens mee akkoord gaat.',
                  style: new TextStyle(
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Akkoord',
                style: new TextStyle(color: Colors.lightBlue),
              ),
              onPressed: () {
                _register();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                'Niet akkoord',
                style: new TextStyle(color: Colors.lightBlue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  //Shows a given message at the bottom of the screen
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      duration: Duration(seconds: 4),
    ));
  }

  //This method gets called when the page is disposing
  //We overwrite it to:
  // - Dispose of our controllers
  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    instituteController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //The firstname textfield
    final voornaam = TextField(
      controller: firstnameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Voornaam',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //The lastname textfield
    final achternaam = TextField(
      controller: lastnameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Achternaam',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //The institution textfield
    final onderwijsinstelling = TextField(
      controller: instituteController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Onderwijsinstelling',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //The email textfield
    final email = TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'E-mailadres',
          hintText: 'naam@student.arteveldehs.be',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //The password textfield
    final wachtwoord = TextField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Wachtwoord',
          hintText: '**********',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //The repeat password textfield
    final herhaalWachtwoord = TextField(
      controller: repeatPasswordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
          labelText: 'Herhaal wachtwoord',
          hintText: '**********',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //The register button
    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            //Form validation
            if (_allFieldsFilledIn()) {
              if (passwordController.text.toString().length >= 6) {
                if (passwordController.text == repeatPasswordController.text) {
                  //Display GDPR dialog
                  _displayGDPRDialog();
                } else {
                  _showSnackBar(
                      "Wachtwoord en herhaal wachtwoord zijn niet gelijk aan elkaar.");
                }
              } else {
                _showSnackBar(
                    "Uw wachtwoord moet minstens 6 karakters lang zijn.");
              }
            } else {
              _showSnackBar("Gelieve alle velden in te vullen.");
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Maak uw account aan',
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    //The login button
    final loginLabel = FlatButton(
      child: Text('Al een account? Log hier in!',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black54,
          )),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title:
            new Text("Account aanmaken", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Center(
        //A list containing all previously declared widgets
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            voornaam,
            SizedBox(height: 8.0),
            achternaam,
            SizedBox(height: 8.0),
            onderwijsinstelling,
            SizedBox(height: 8.0),
            email,
            SizedBox(height: 8.0),
            wachtwoord,
            SizedBox(height: 8.0),
            herhaalWachtwoord,
            SizedBox(height: 24.0),
            registerButton,
            loginLabel
          ],
        ),
      ),
    );
  }
}
