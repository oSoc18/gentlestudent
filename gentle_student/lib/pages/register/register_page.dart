import 'package:Gentle_Student/pages/information/information_page.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  //This tag is used for navigation
  static String tag = 'register-page';
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //Creating the widgets and building the scaffold
  @override
  Widget build(BuildContext context) {
    //Voornaam widget
    final voornaam = TextField(
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
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
          labelText: 'Onderwijsinstelling',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );

    //E-mail widget
    final email = TextField(
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
            //Testing
            Navigator.of(context).pushNamed(InformationPage.tag);
          },
          color: Colors.lightBlueAccent,
          child: Text('Registreer', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    //LoginLabel widget
    final loginLabel = FlatButton(
      child:
          Text('Al een account? Log hier in!', style: TextStyle(color: Colors.black54)),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    //Using all the widgets and create an AppBar to build a scaffold
    return Scaffold(
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