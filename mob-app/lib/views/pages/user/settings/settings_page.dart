import 'dart:async';
import 'dart:io';

import 'package:Gentle_Student/database/database_helper.dart';
import 'package:Gentle_Student/network/api.dart';
import 'package:Gentle_Student/utils/firebase_utils.dart';
import 'package:Gentle_Student/views/pages/authentication/login_page.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

//A page containing all settings the user can change
class SettingsPage extends StatefulWidget {
  //This tag allows us to navigate to the SettingsPage
  static String tag = 'settings-page';

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  //Declaration of the variables
  final db = new DatabaseHelper();
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _switchValue = false;
  File _image;
  String _path;

  //Function for switching between dark mode and light mode
  void _changeBrightnessAndColor() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  //Function to change dark mode switch value on page creation
  void _setSwitchState() async {
    if (Theme.of(context).brightness == Brightness.dark)
      setState(() {
        _switchValue = true;
      });
    else
      setState(() {
        _switchValue = false;
      });
  }

  //Function for signing out
  Future<Null> _signOut() async {
    try {
      await FirebaseUtils.mAuth.signOut();
      FirebaseUtils.firebaseUser = null;
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
              child: new Text(
                'Ja',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
              onPressed: () {
                _signOut();
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                'Neen',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
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

  //Let user choose between camera and gallery
  Future<Null> _displayCameraOrGalleryDialog() async {
    return showDialog<Null>(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Profielfoto"),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(
                    'Wilt u de camera gebruiken om een nieuwe foto nemen of wilt u een bestaande foto uit uw gallerij gebruiken?'),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Camera',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await getImage(ImageSource.camera);
              },
            ),
            new FlatButton(
              child: new Text(
                'Gallerij',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                await getImage(ImageSource.gallery);
              },
            ),
          ],
        );
      },
    );
  }

  //Let user take a picture or choose an existing picture from their gallery
  Future<Null> getImage(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);

    setState(() {
      _image = image;
    });

    await uploadFile();
  }

  //Upload file to Firebase storage and change profile picture of the user
  Future<Null> uploadFile() async {
    try {
      final StorageReference ref = FirebaseStorage.instance.ref().child(
          "Profilepictures/" +
              (await FirebaseUtils.firebaseUser).uid +
              "/profile_picture.jpg");
      final StorageUploadTask task = ref.putFile(_image);
      final Uri downloadUrl = (await task.future).downloadUrl;
      _path = downloadUrl.toString();

      final ParticipantApi participantApi = new ParticipantApi();
      await participantApi.changeProfilePicture(
          (await FirebaseUtils.firebaseUser).uid, _path);

      _showSnackBar("Uw profielfoto werd succesvol bijgewerkt.");
    } catch (E) {
      _showSnackBar(
          "Er ging iets mis tijdens het bijwerken van uw profielfoto.");
    }
  }

  //Location permission dialog
  Future<Null> _displayLocationPermissionDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text("Locatie permissie"),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text(
                  'De plugin die gebruikt wordt voor de map heeft (voorlopig) geen gebruiker locatie ondersteuning. U hoeft de permissie tot uw locatie momenteel nog niet te geven.',
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                'Oke',
                style: TextStyle(
                  color: Colors.lightBlue,
                ),
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    _setSwitchState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Instellingen", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      key: scaffoldKey,
      //A list containing all settings
      body: ListView(
        children: <Widget>[
          //Profile picture setting
          Container(
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Wijzig profielfoto'),
              onTap: () => _displayCameraOrGalleryDialog(),
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(),
              ),
            ),
          ),

          //Dark mode setting
          Container(
            child: ListTile(
              trailing: Switch(
                activeColor: Colors.lightBlue,
                value: _switchValue,
                onChanged: (bool newValue) {
                  setState(() {
                    _switchValue = newValue;
                  });
                  _changeBrightnessAndColor();
                },
              ),
              title: Text('Donkere modus'),
              onTap: () {
                setState(() {
                  _switchValue = !_switchValue;
                });
                _changeBrightnessAndColor();
              },
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(),
              ),
            ),
          ),

          //Location permission setting
          Container(
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Sta locatie altijd toe'),
              onTap: () => _displayLocationPermissionDialog(),
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(),
              ),
            ),
          ),

          //Sign out setting
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
