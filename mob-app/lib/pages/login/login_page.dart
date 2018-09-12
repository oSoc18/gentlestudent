import 'package:Gentle_Student/data/database_helper.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:Gentle_Student/navigation/home_page.dart';
import 'package:Gentle_Student/pages/information/tutorial/tutorial_page.dart';
import 'package:Gentle_Student/pages/register/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/material.dart';

//This page is the first page the user will see after installing the app
//It handles everything that's login related
class LoginPage extends StatefulWidget {
  //This tag allows us to navigate to the LoginPage
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Declaration of the variables
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  var emailController;
  var passwordController;
  final db = new DatabaseHelper();

  //Constructor
  _LoginPageState() {
    emailController = new TextEditingController();
    passwordController = new TextEditingController();
  }

  //Function for handling the login
  void _login() async {
    if (_allFieldsFilledIn()) {
      try {
        //Authentication via Firebase
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        //Storing the user in the local database
        User huidigeUser = await db.getUser();
        if (huidigeUser == null) {
          await db.saveUser(
              new User(emailController.text, passwordController.text));
          //Navigating to the TutorialPage
          Navigator.pushReplacement(
            context,
            new MaterialPageRoute(
              builder: (BuildContext context) => new TutorialPage(true),
            ),
          );
        } else {
          await db.updateUser(
              new User(emailController.text, passwordController.text));
          //If there is already is a user in the database,
          //Skip the TutorialPage and proceed to the HomePage
          Navigator.of(context).pushReplacementNamed(HomePage.tag);
        }
      } catch (Error) {
        _showSnackBar("Er is iets fout gelopen tijdens het aanmelden.");
      }
    } else {
      _showSnackBar("Gelieve alle velden in te vullen.");
    }
  }

  //Custom form validation to check if all fields are filled in
  bool _allFieldsFilledIn() {
    return emailController.text != null &&
        emailController.text != "" &&
        passwordController.text != null &&
        passwordController.text != "";
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //The logo displayed at the top of the page
    final logo = Hero(
        tag: 'login hero',
        child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 60.0,
            child: Image.asset('assets/icon/logo.png')));

    //The email textfield
    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'E-mailadres',
        hintText: 'naam@student.arteveldehs.be',
        labelStyle: TextStyle(
          color: Colors.lightBlue,
          decorationColor: Colors.lightBlue,
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //The password textfield
    final password = TextField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        fillColor: Colors.lightBlue,
        labelText: 'Wachtwoord',
        hintText: '**********',
        //labelStyle: TextStyle(color: Colors.lightBlue),
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    //The login button
    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () => _login(),
          color: Colors.lightBlueAccent,
          child: Text('Log in', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    //The register button
    final registerLabel = FlatButton(
      child: Text('Geen account? Klik hier!',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black54,
          )),
      onPressed: () {
        Navigator.of(context).pushNamed(RegisterPage.tag);
      },
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Login", style: TextStyle(color: Colors.white)),
      ),
      key: scaffoldKey,
      body: Center(
        //A list containing all previously declared widgets
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registerLabel
          ],
        ),
      ),
    );
  }
}
