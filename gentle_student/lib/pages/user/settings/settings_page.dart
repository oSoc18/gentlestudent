import 'dart:async';

import 'package:Gentle_Student/data/database_helper.dart';
import 'package:Gentle_Student/pages/login/login_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  static String tag = 'settings-page';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //Declaration of the variables
  final db = new DatabaseHelper();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void changeColor() {
    DynamicTheme.of(context).setThemeData(new ThemeData(
        primaryColor: Theme.of(context).primaryColor == Colors.lightBlue
            ? Colors.red
            : Colors.indigo));
  }

  //Function for signing out
  Future<Null> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await db.deleteUser();
    } catch (Error) {
      _showSnackBar("Er is een fout opgetreden tijdens het afmelden.");
    }
    Navigator.of(context).pushNamedAndRemoveUntil(
          LoginPage.tag,
          (Route<dynamic> r) => false,
        );
  }

  //Dialog for signing out
  Future<Null> _displaySignOutDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Afmelden"),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('Bent u zeker dat u zich wilt afmelden?'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Ja'),
              onPressed: () {
                _signOut();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Instellingen", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      key: scaffoldKey,
      body: ListView(
        children: <Widget>[
          Container(
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Wijzig profielfoto'),
              onTap: () {
                changeBrightness();
                changeColor();
              },
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(),
              ),
            ),
          ),
          Container(
            child: ListTile(
              trailing: Switch(
                value: false,
                onChanged: null,
              ),
              title: Text('Donkere modus'),
              onTap: () => {},
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(),
              ),
            ),
          ),
          Container(
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Sta locatie altijd toe'),
              onTap: () => {},
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(),
              ),
            ),
          ),
          Container(
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Meld af'),
              onTap: () => _displaySignOutDialog(),
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Shows a given message at the bottom of the screen
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      duration: Duration(seconds: 4),
    ));
  }
}
