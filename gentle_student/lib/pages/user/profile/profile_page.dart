import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  static String tag = 'profile-page';
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 60.0,
        child: Icon(
          Icons.account_circle,
          size: 120.0,
        ),
      ),
    );

    final name = Text(
      'Stijn Mets',
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
      'gentlestudent@student.arteveldehs.be',
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    final education = Text(
      'Grafische en Digitale media',
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    final institute = Text(
      'Artevelde Hogeschool',
      textAlign: TextAlign.center,
      style: new TextStyle(
        color: Colors.black38,
        fontSize: 14.0,
      ),
    );

    final birthdate = Text(
      '23/01/1998',
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
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          new Container(
            color: color,
            height: 300.0,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(height: 24.0),
                logo,
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
        ],
      ),
    );
  }
}
