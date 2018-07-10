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

  Column buildButtonColumn(IconData icon, String label, String tag) {
      Color color = Theme.of(context).primaryColor;

      return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(icon, color: color, size: 48.0),
            onPressed: () {
              Navigator.of(context).pushNamed(tag);
            },
          ),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: color,
              ),
            ),
          ),
        ],
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
            buildButtonColumn(Icons.account_circle, "Profiel", ProfilePage.tag),
            buildButtonColumn(Icons.work, "Backpack", BackPackPage.tag),
            buildButtonColumn(Icons.school, "Leerkansen", MyLearningOpportunitiesPage.tag),
            buildButtonColumn(Icons.favorite, "Favorieten", FavoritesPage.tag),
            buildButtonColumn(Icons.settings, "Instellingen", SettingsPage.tag),
          ],
        ),
    );
  }
}
