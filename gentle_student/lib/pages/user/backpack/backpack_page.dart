import 'dart:async';

import 'package:Gentle_Student/data/database_helper.dart';
import 'package:Gentle_Student/data/rest_data.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:Gentle_Student/models/user_token.dart';
import 'package:flutter/material.dart';

class BackPackPage extends StatefulWidget {
  static String tag = 'backpack-page';
  @override
  _BackPackPageState createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  User user;
  String token;
  List<dynamic> _badges = [];
  RestDatasource _api;

  @override
  void initState() {
    super.initState();
    _doLogin("van-driessche-maxime@hotmail.com", "osocosoc");
    _loadFromBadgr();
  }

  _doLogin(String username, String password) {
    RestDatasource api = new RestDatasource();
    api.login(username, password).then((token) {
      print("login succesfull");
      print(token);
      var user = User(name: username,password: password, userId: "1", kind: "participant");
      onLoginSuccess(user, token);
    }).catchError((Exception error) => print("login failed"));
  }

  void onLoginSuccess(User user, String token) async {
    var db = new DatabaseHelper();
    await db.deleteUserTokens();
    var userToken = UserToken(user, token);
    await db.saveUserToken(userToken);
  }

  _loadFromBadgr() async {
    var db = new DatabaseHelper();
    token = await db.getToken();
    final api = new RestDatasource();
    final badges = await api.getBadges(token);
    setState(() {
      _api = api;
      _badges = badges;
    });
  }

  _reloadBadges() async {
    if (_api != null) {
      final badges = await _api.getBadges(token);
      setState(() {
        _badges = badges;
      });
    }
  }

  // _navigateToOpportunityDetails(Opportunity opportunity) {
  //   Navigator.push(
  //       context,
  //       new MaterialPageRoute(
  //           builder: (BuildContext context) =>
  //               new OpportunityDetailsPage(opportunity)));
  // }

  Widget _buildBadgeItem(BuildContext context, int index) {
    Badge badge = _badges[index];

    return new Container(
      margin: const EdgeInsets.only(top: 3.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () {
                // _navigateToOpportunityDetails(opportunity);
              },
              leading: new Hero(
                tag: index,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(badge.image), radius: 40.0,
                ),
              ),
              title: new Text(
                badge.name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 21.0),
              ),
              subtitle: new Text(_getCategory(badge) +
                  " - " +
                  _getDifficulty(badge) +
                  "\n" +
                  badge.issuerName),
              isThreeLine: true,
              dense: false,
            ),
          ],
        ),
      ),
    );
  }

  String _getDifficulty(Badge badge) {
    switch (badge.difficulty) {
      case Difficulty.BEGINNER:
        return "Niveau 1";
      case Difficulty.INTERMEDIATE:
        return "Niveau 2";
      case Difficulty.EXPERT:
        return "Niveau 3";
    }
    return "Niveau 0";
  }

  String _getCategory(Badge badge) {
    switch (badge.category) {
      case Category.DIGITALEGELETTERDHEID:
        return "Digitale geletterdheid";
      case Category.DUURZAAMHEID:
        return "Duurzaamheid";
      case Category.ONDERNEMINGSZIN:
        return "Ondernemingszin";
      case Category.ONDERZOEK:
        return "Onderzoek";
      case Category.WERELDBURGERSCHAP:
        return "Wereldburgerschap";
    }
    return "Algemeen";
  }

  Future<Null> refresh() {
    _reloadBadges();
    return new Future<Null>.value();
  }

  Widget _getListViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _badges.length,
            itemBuilder: _buildBadgeItem),
      ),
    );
  }

  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      child: new Column(
        children: <Widget>[_getListViewWidget()],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leerkansen", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: _buildBody(),
    );
  }
}
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         title: new Text("Backpack", style: TextStyle(color: Colors.white)),
//         iconTheme: new IconThemeData(color: Colors.white),
//       ),
//       backgroundColor: Colors.white,
//       body:
//         new FutureBuilder<dynamic>(
//           future: getBadges(),
//           initialData: "Loading badges..",
//           builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//             GridView.count(
//               crossAxisCount: 3,
//               children: [
//                 snapshot.data
//               ],
//             );
//           },
//         )
//     );
//   }
// }
