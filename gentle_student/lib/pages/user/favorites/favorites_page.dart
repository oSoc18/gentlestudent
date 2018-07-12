import 'package:flutter/material.dart';

class FavoritesPage extends StatefulWidget {
  static String tag = 'favorites-page';
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Favorieten", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
    );
  }
}
