import 'package:Gentle_Student/pages/user/backpack/backpack_page.dart';
import 'package:Gentle_Student/pages/user/favorites/favorites_page.dart';
import 'package:Gentle_Student/pages/user/my_learning_opportunities/my_learning_opportunities_page.dart';
import 'package:Gentle_Student/pages/user/profile/profile_page.dart';
import 'package:Gentle_Student/pages/user/settings/settings_page.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  static String tag = 'user-page';

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
          //Profile page
          Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(ProfilePage.tag),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.lightBlue,
                      size: 56.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ProfilePage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Profiel",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //BackPack page
          Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(BackPackPage.tag),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.work,
                      color: Colors.lightBlue,
                      size: 64.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(BackPackPage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Backpack",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //MyLearningOpportunities page
          Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(MyLearningOpportunitiesPage.tag),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.school,
                      color: Colors.lightBlue,
                      size: 64.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(MyLearningOpportunitiesPage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Leerkansen",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Favorites page
          Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(FavoritesPage.tag),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Colors.lightBlue,
                      size: 64.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(FavoritesPage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Favorieten",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Settings page
          Center(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(SettingsPage.tag),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      color: Colors.lightBlue,
                      size: 64.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SettingsPage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 30.0),
                      child: Text(
                        "Instellingen",
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
