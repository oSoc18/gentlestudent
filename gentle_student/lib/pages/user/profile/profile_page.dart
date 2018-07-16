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
            child: Icon(Icons.account_circle, size: 120.0,)/*Image.asset('assets/crest-gentlestudent.png')*/));

    final name = Text(
      'Stijn Mets',
      textAlign: TextAlign.center,
      style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 24.0),
    );

    final lbl_mail = Text(
      'E-mail',
      textAlign: TextAlign.center,
      style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 16.0),
    );

    final lbl_education = Text(
      'Richting',
      textAlign: TextAlign.center,
      style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 16.0),
    );

    final lbl_institute = Text(
      'Onderwijsinstelling',
      textAlign: TextAlign.center,
      style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 16.0),
    );

    final lbl_birthday = Text(
      'Geboortedatum',
      textAlign: TextAlign.center,
      style: new TextStyle(fontWeight: FontWeight.bold, color: Colors.black45, fontSize: 16.0),
    );

    final mail = Text(
      'gentlestudent@student.arteveldehs.be',
      textAlign: TextAlign.center,
      style: new TextStyle(color: Colors.black38, fontSize: 14.0),
    );

    final education = Text(
      'Grafische en Digitale media',
      textAlign: TextAlign.center,
      style: new TextStyle(color: Colors.black38, fontSize: 14.0),
    );

    final institute = Text(
      'Artevelde Hogeschool',
      textAlign: TextAlign.center,
      style: new TextStyle(color: Colors.black38, fontSize: 14.0),
    );

    final birthday = Text(
      '23/01/1998',
      textAlign: TextAlign.center,
      style: new TextStyle(color: Colors.black38, fontSize: 14.0),
    );

    return Scaffold(
      appBar: new AppBar(
        title: new Text("Profiel", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: ListView(

          shrinkWrap: true,

          children: <Widget>[
            new Container(
              //padding: EdgeInsets.only(left: 24.0, right: 24.0, top: 8.0),
              //margin: const EdgeInsets.only(top: 10.0),
              color: color,
              height: 300.0,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 24.0),
                  logo,
                  SizedBox(height: 24.0),
                  name,
                  Container(
                    //color: Colors.white,
                    margin: EdgeInsets.only(left: 48.0, right: 48.0, top: 20.0),
                    height: 330.0,
                    width: 50.0,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                      //border: new Border.all(color: Colors.lightBlue),
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
                      children: <Widget>[
                        SizedBox(height: 30.0),
                        lbl_mail,
                        mail,
                        SizedBox(height: 30.0),
                        lbl_institute,
                        institute,
                        SizedBox(height: 30.0),
                        lbl_education,
                        education,
                        SizedBox(height: 30.0),
                        lbl_birthday,
                        birthday,
                      ],
                    ),
                  )
                ],

              ),
            ),


            /*SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            registerLabel*/
          ],
        ),
    );
  }
}
