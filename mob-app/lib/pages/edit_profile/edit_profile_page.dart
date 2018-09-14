import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  final name, institute;
  EditProfilePage(this.name, this.institute);
  @override
  _EditProfilePageState createState() => _EditProfilePageState(name, institute);
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _firstname, _lastname, _institute;
  TextEditingController firstnameController;
  TextEditingController lastnameController;
  TextEditingController instituteController;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  _EditProfilePageState(String name, String institute) {
    _firstname = name.substring(0, name.indexOf(" "));
    _lastname = name.substring(name.indexOf(" ") + 1);
    _institute = institute;
    firstnameController = new TextEditingController(text: _firstname);
    lastnameController = new TextEditingController(text: _lastname);
    instituteController = new TextEditingController(text: _institute);
  }

  //Custom form validation to check if all fields are filled in
  bool _allFieldsFilledIn() {
    return firstnameController.text != null &&
        firstnameController.text != "" &&
        lastnameController.text != null &&
        lastnameController.text != "" &&
        instituteController.text != null &&
        instituteController.text != "";
  }

  //Shows a given message at the bottom of the screen
  void _showSnackBar(String text) {
    scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(text),
      duration: Duration(seconds: 4),
    ));
  }

  @override
  void dispose() {
    firstnameController.dispose();
    lastnameController.dispose();
    instituteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Message about changing email address and password
    final boodschap = Text(
      "Uw e-mailadres en/of wachtwoord wijzigen kan voorlopig nog niet.",
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
    );

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
              Navigator.of(context).pop(
                List.of([
                  firstnameController.text + " " + lastnameController.text,
                  instituteController.text,
                ]),
              );
            } else {
              _showSnackBar("Gelieve alle velden in te vullen.");
            }
          },
          color: Colors.lightBlueAccent,
          child: Text('Wijzig gegevens', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    return Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
        title:
            new Text("Profiel wijzigen", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Center(
        //A list containing all previously declared widgets
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            boodschap,
            SizedBox(height: 30.0),
            voornaam,
            SizedBox(height: 8.0),
            achternaam,
            SizedBox(height: 8.0),
            onderwijsinstelling,
            SizedBox(height: 24.0),
            registerButton,
          ],
        ),
      ),
    );
  }
}
