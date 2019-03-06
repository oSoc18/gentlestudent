import 'dart:async';

import 'package:Gentle_Student/constants/string_constants.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:Gentle_Student/utils/message_utils.dart';
import 'package:Gentle_Student/utils/website_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  static String tag = 'register-page';

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final firstnameController = new TextEditingController();
  final lastnameController = new TextEditingController();
  final instituteController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final repeatPasswordController = new TextEditingController();

  Future<void> _register() async {
    try {
      FirebaseUtils.firebaseUser =
          FirebaseUtils.mAuth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (await FirebaseUtils.firebaseUser != null) {
        FirebaseUser firebaseUser = await FirebaseUtils.firebaseUser;

        UserUpdateInfo userUpdateInfo = new UserUpdateInfo();
        userUpdateInfo.displayName =
            "${firstnameController.text} ${lastnameController.text}";
        await FirebaseUtils.mAuth.updateProfile(userUpdateInfo);

        firebaseUser.sendEmailVerification();

        await _addUserToFirestore();

        FirebaseUtils.firebaseUser = null;
        await FirebaseUtils.mAuth.signOut();

        Navigator.of(context).pop();
      } else {
        MessageUtils.showSnackBar(
            scaffoldKey, StringConstants.errorRegistrationGeneral);
      }
    } catch (Error) {
      MessageUtils.showSnackBar(
          scaffoldKey, StringConstants.errorRegistrationGeneral);
    }
  }

  Future _addUserToFirestore() async {
    Map<String, dynamic> data = <String, dynamic>{
      "name": firstnameController.text + " " + lastnameController.text,
      "institute": instituteController.text,
      "email": emailController.text,
      "profilePicture": "",
      "favorites": new List<String>(),
    };

    final DocumentReference documentReference = Firestore.instance
        .document("Participants/" + (await FirebaseUtils.firebaseUser).uid);

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

  Future<void> _displayGDPRDialog() async {
    return showDialog<void>(
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
                      await WebsiteUtils.launchInBrowser(
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
    final voornaam = TextField(
      controller: firstnameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Voornaam',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final achternaam = TextField(
      controller: lastnameController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Achternaam',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final onderwijsinstelling = TextField(
      controller: instituteController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'Onderwijsinstelling',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final email = TextField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        labelText: 'E-mailadres',
        hintText: 'naam@student.arteveldehs.be',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final wachtwoord = TextField(
      controller: passwordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Wachtwoord',
        hintText: '**********',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final herhaalWachtwoord = TextField(
      controller: repeatPasswordController,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'Herhaal wachtwoord',
        hintText: '**********',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            if (_allFieldsFilledIn()) {
              if (passwordController.text.toString().length >= 6) {
                if (passwordController.text == repeatPasswordController.text) {
                  _displayGDPRDialog();
                } else {
                  MessageUtils.showSnackBar(scaffoldKey,
                      StringConstants.validationPasswordsDoNotMatch);
                }
              } else {
                MessageUtils.showSnackBar(
                    scaffoldKey, StringConstants.validationInvalidPassword);
              }
            } else {
              MessageUtils.showSnackBar(
                  scaffoldKey, StringConstants.validationErrorEmptyField);
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Maak uw account aan',
              style: TextStyle(color: Colors.white)),
        ),
      ),
    );

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
