import 'package:Gentle_Student/constants/string_constants.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:Gentle_Student/utils/message_utils.dart';
import 'package:Gentle_Student/utils/validation_utils.dart';
import 'package:Gentle_Student/views/pages/authentication/register_page.dart';
import 'package:Gentle_Student/views/pages/information/tutorial/tutorial_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!ValidationUtils.allFieldsFilledIn(
        [emailController, passwordController]))
      MessageUtils.showSnackBar(
          scaffoldKey, StringConstants.validationErrorEmptyField);

    try {
      FirebaseUtils.firebaseUser =
          FirebaseUtils.mAuth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      if (!(await FirebaseUtils.firebaseUser).isEmailVerified) {
        FirebaseUtils.firebaseUser = null;
        await FirebaseUtils.mAuth.signOut();
        MessageUtils.showSnackBar(
            scaffoldKey, StringConstants.errorLoginUnverifiedEmail);
      }

      _navigateToTutorialPage();
    } catch (Error) {
      MessageUtils.showSnackBar(scaffoldKey, StringConstants.errorLoginGeneral);
    }
  }

  void _navigateToTutorialPage() {
    Navigator.pushReplacement(
      context,
      new MaterialPageRoute(
        builder: (BuildContext context) => new TutorialPage(true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'login hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
        child: Image.asset('assets/icon/logo.png'),
      ),
    );

    final email = TextField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      controller: emailController,
      decoration: InputDecoration(
        labelText: 'E-mailadres',
        hintText: 'naam@student.arteveldehs.be',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final password = TextField(
      autofocus: false,
      obscureText: true,
      controller: passwordController,
      decoration: InputDecoration(
        fillColor: Colors.lightBlue,
        labelText: 'Wachtwoord',
        hintText: '**********',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(10.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () => _login(),
          color: Colors.lightBlueAccent,
          child: Text('Log in', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

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
            registerLabel,
          ],
        ),
      ),
    );
  }
}
