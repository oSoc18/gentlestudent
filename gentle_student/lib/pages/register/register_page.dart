import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseUser;
import 'package:flutter/services.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

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
  DateTime _birthdate = new DateTime.now();
  final String privacyPolicyLink = "assets/PrivacyPolicy.txt";
  String _privacyPolicy = "";

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
  //Date formatter
  static String _formatDate(DateTime date) {
    return formatDate(date, [yyyy, '-', mm, '-', dd]);
  }

  //Register with Firebase
  void _register() async {
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
  }

  //Add user details to database
  void _addUserToDatabase() {
    Map<String, String> data = <String, String>{
      "name": firstnameController.text + " " + lastnameController.text,
      "birthdate": _formatDate(_birthdate),
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
        _birthdate != DateTime.now() &&
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

  //Dialog for GDPR reasons
  Future<Null> _displayGDPRDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Privacybeleid & voorwaarden"),
          content: new SingleChildScrollView(
            child: new HtmlView(
              data: _privacyPolicy,
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Akkoord'),
              onPressed: () {
                _register();
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

  Future<String> _getPrivacyPolicy(String path) async {
    return await rootBundle.loadString(path);
  }

  void _fillInPrivacyPolicy() async {
    String privacyPolicy = await _getPrivacyPolicy(privacyPolicyLink);
    setState(() {
      _privacyPolicy = privacyPolicy;
    });
  }

  //Shows a given message at the bottom of the screen
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      duration: Duration(seconds: 4),
    ));
  }

  @override
  void initState() {
    super.initState();
    _fillInPrivacyPolicy();
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
    final geboortedatum = new _DateTimePicker(
      labelText: 'Geboortedatum',
      selectedDate: _birthdate,
      selectDate: (DateTime date) {
        if (this.mounted) {
          setState(() {
            _birthdate = date;
          });
        }
      },
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
          onPressed: () {
            if (_allFieldsFilledIn()) {
              if (passwordController.text.toString().length >= 6) {
                if (passwordController.text == repeatPasswordController.text) {
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
        title:
            new Text("Account aanmaken", style: TextStyle(color: Colors.white)),
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
            SizedBox(height: 10.0),
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

class _InputDropdown extends StatelessWidget {
  const _InputDropdown(
      {Key key,
      this.child,
      this.labelText,
      this.valueText,
      this.valueStyle,
      this.onPressed})
      : super(key: key);

  final String labelText;
  final String valueText;
  final TextStyle valueStyle;
  final VoidCallback onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: onPressed,
      child: new InputDecorator(
        decoration: InputDecoration(
            labelText: labelText,
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(valueText, style: valueStyle),
            new Icon(Icons.arrow_drop_down,
                color: Theme.of(context).brightness == Brightness.light
                    ? Colors.grey.shade700
                    : Colors.white70),
          ],
        ),
      ),
    );
  }
}

class _DateTimePicker extends StatelessWidget {
  const _DateTimePicker({
    Key key,
    this.labelText,
    this.selectedDate,
    this.selectDate,
  }) : super(key: key);

  final String labelText;
  final DateTime selectedDate;
  final ValueChanged<DateTime> selectDate;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) selectDate(picked);
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.all(0.0),
      child: Row(
        children: <Widget>[
          new Expanded(
            child: new _InputDropdown(
              labelText: labelText,
              valueText: _formatDate(selectedDate),
              valueStyle: TextStyle(fontSize: 16.0),
              onPressed: () {
                _selectDate(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  //Date formatter
  static String _formatDate(DateTime date) {
    return formatDate(date, [dd, '/', mm, '/', yyyy]);
  }
}
