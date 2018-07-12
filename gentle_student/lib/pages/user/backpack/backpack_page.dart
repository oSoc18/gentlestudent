import 'package:Gentle_Student/data/rest_data.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:flutter/material.dart';

class BackPackPage extends StatefulWidget {
  static String tag = 'backpack-page';
  @override
  _BackPackPageState createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  User user;
  String token;

  doLogin(String username, String password) {
    RestDatasource api = new RestDatasource();
    api.login(username, password).then((token) {
      print("login succesfull");
      print(token);
      user = 
      onLoginSuccess(user, token);
    }).catchError((Exception error) => print("login failed"));
  }

  void onLoginSuccess(User user, String token) async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Backpack", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body:
        IconButton(
            icon: Icon(Icons.account_circle, size: 48.0),
            onPressed: () {
              doLogin("van-driessche-maxime@hotmail.com", "yeix6chi");
            },
          )
    );
  }
}
