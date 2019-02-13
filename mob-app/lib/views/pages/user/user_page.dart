import 'package:Gentle_Student/views/pages/user/backpack/backpack_page.dart';
import 'package:Gentle_Student/views/pages/user/favorites/favorites_page.dart';
import 'package:Gentle_Student/views/pages/user/my_learning_opportunities/my_learning_opportunities_page.dart';
import 'package:Gentle_Student/views/pages/user/profile/profile_page.dart';
import 'package:Gentle_Student/views/pages/user/settings/settings_page.dart';
import 'package:flutter/material.dart';

//This page allows navigation to all user related pages
class UserPage extends StatelessWidget {
  //This tag allows us to navigate to the UserPage
  static String tag = 'user-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Gebruiker", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      //List of all user related pages
      body: GridView.count(
        crossAxisCount: 3,
        children: [

          //Navigate to the ProfilePage
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
                      padding: EdgeInsets.only(top: 22.0),
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

          //Navigate to the BackpackPage
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
                      size: 56.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(BackPackPage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 22.0),
                      child: Text(
                        "Backpack",
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

          //Navigate to the MyLearningOpportunitiesPage
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
                      size: 56.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(MyLearningOpportunitiesPage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 22.0),
                      child: Text(
                        "Leerkansen",
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

          //Navigate to the FavoritesPage
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
                      size: 56.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(FavoritesPage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 22.0),
                      child: Text(
                        "Favorieten",
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

          //Navigate to the SettingsPage
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
                      size: 56.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SettingsPage.tag);
                    },
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 22.0),
                      child: Text(
                        "Instellingen",
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
        ],
      ),
    );
  }
}
