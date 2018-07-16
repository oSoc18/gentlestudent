import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth, FirebaseUser;

class RegisterPage extends StatefulWidget {
  //This tag is used for navigation
  static String tag = 'register-page';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Variables
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseUser firebaseUser;
  var firstnameController;
  var lastnameController;
  var birthdateController;
  var instituteController;
  var educationController;
  var emailController;
  var passwordController;
  var repeatPasswordController;

  //Constructor
  _RegisterPageState() {
    firstnameController = new TextEditingController();
    lastnameController = new TextEditingController();
    birthdateController = new TextEditingController();
    instituteController = new TextEditingController();
    educationController = new TextEditingController();
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
    repeatPasswordController = new TextEditingController();
  }

  //Functions
  //Register with Firebase
  void _register() async {
    if (_allFieldsFilledIn()) {
      if (passwordController.text.toString().length >= 6) {
        if (passwordController.text == repeatPasswordController.text) {
          try {
            firebaseUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text,
              password: passwordController.text,
            );
            _addUserToDatabase();
            Navigator.of(context).pop();
          } catch (Error) {
            _showSnackBar("Er is iets fout gelopen tijdens het registeren.");
          }
        } else {
          _showSnackBar(
              "Wachtwoord en herhaal wachtwoord zijn niet gelijk aan elkaar.");
        }
      } else {
        _showSnackBar("Uw wachtwoord moet minstens 6 karakters lang zijn.");
      }
    } else {
      _showSnackBar("Gelieve alle velden in te vullen.");
    }
  }

  //Add user details to database
  void _addUserToDatabase() {
    Map<String, String> data = <String, String>{
      "firstname": firstnameController.text,
      "lastname": lastnameController.text,
      "birthdate": birthdateController.text,
      "institute": instituteController.text,
      "education": educationController.text,
      "email": emailController.text,
    };
    final DocumentReference documentReference =
      Firestore.instance.document("Participants/" + firebaseUser.uid);
    documentReference.setData(data).whenComplete(() {
      print("User added");
    }).catchError((e) => print(e));
  }

  //Custom form validation
  bool _allFieldsFilledIn() {
    return firstnameController.text != null &&
        firstnameController.text != "" &&
        lastnameController.text != null &&
        lastnameController.text != "" &&
        birthdateController.text != null &&
        birthdateController.text != "" &&
        instituteController.text != null &&
        instituteController.text != "" &&
        educationController.text != null &&
        educationController.text != "" &&
        emailController.text != null &&
        emailController.text != "" &&
        passwordController.text != null &&
        passwordController.text != "" &&
        repeatPasswordController.text != null &&
        repeatPasswordController.text != "";
  }

  //Shows a given message at the bottom of the screen
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      duration: Duration(seconds: 4),
    ));
  }

  //We need to dispose of our controllers
  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    birthdateController.dispose();
    instituteController.dispose();
    educationController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    super.dispose();
  }

  //Creating the widgets and building the scaffold
  @override
  Widget build(BuildContext context) {
    //Voornaam widget
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

    //Achternaam widget
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

    //Geboortedatum widget
    final geboortedatum = TextField(
      controller: birthdateController,
      keyboardType: TextInputType.datetime,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Geboortedatum',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //Onderwijsinstelling widget
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

    //Onderwijsinstelling widget
    final opleiding = TextField(
      controller: educationController,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Opleiding',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //E-mail widget
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

    //Wachtwoord widget
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

    //HerhaalWachtwoord widget
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

    //RegisterButton widget
    final registerButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () => _register(),
          color: Colors.lightBlueAccent,
          child: Text('Registreer', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    //LoginLabel widget
    final loginLabel = FlatButton(
      child: Text('Al een account? Log hier in!',
          style: TextStyle(color: Colors.black54)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    //Using all the widgets and create an AppBar to build a scaffold
    return Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title: new Text("Registreren", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            //SizedBox leaves blank space to make the UI look cleaner
            SizedBox(height: 8.0),
            voornaam,
            SizedBox(height: 8.0),
            achternaam,
            SizedBox(height: 8.0),
            geboortedatum,
            SizedBox(height: 8.0),
            onderwijsinstelling,
            SizedBox(height: 8.0),
            opleiding,
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
