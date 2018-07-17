import 'package:Gentle_Student/pages/user/profile/profile_page.dart';
import 'package:Gentle_Student/pages/user/backpack/backpack_page.dart';
import 'package:Gentle_Student/pages/user/my_learning_opportunities/my_learning_opportunities_page.dart';
import 'package:Gentle_Student/pages/user/favorites/favorites_page.dart';
import 'package:Gentle_Student/pages/user/settings/settings_page.dart';
import 'package:flutter/material.dart';

class UserPage extends StatefulWidget {
  static String tag = 'user-page';
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  Center _buildButtons(IconData icon, String label, String tag) {
    Color color = Theme.of(context).primaryColor;

    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          IconButton(
            icon: Icon(icon, color: color, size: 64.0),
            onPressed: () {
              Navigator.of(context).pushNamed(tag);
            },
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 32.0),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Gebruiker", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: GridView.count(
        crossAxisCount: 3,
        children: [
          _buildButtons(Icons.account_circle, "Profiel", ProfilePage.tag),
          _buildButtons(Icons.work, "Backpack", BackPackPage.tag),
          _buildButtons(
              Icons.school, "Leerkansen", MyLearningOpportunitiesPage.tag),
          _buildButtons(Icons.favorite, "Favorieten", FavoritesPage.tag),
          _buildButtons(Icons.settings, "Instellingen", SettingsPage.tag),
        ],
      ),
    );
  }
}
