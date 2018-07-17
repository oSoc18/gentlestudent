import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/data/database_helper.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
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
  final token = "bf6a76694eaa7f44807984abb04b77e8c9dbb8f1";
  List<dynamic> _badges = [];
  BadgeApi _api;

  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

  _loadFromFirebase() async {
    BadgeApi api = new BadgeApi();
    final badges = await api.getAllBadges(token);
    setState(() {
      _api = api;
      _badges = badges;
    });
  }

  _reloadBadges() async {
    if (_api != null) {
      final badges = await _api.getAllBadges(token);
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
              subtitle: new Text(
                  badge.issuer),
              isThreeLine: true,
              dense: false,
            ),
          ],
        ),
      ),
    );
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
        title: Text("Backpack", style: TextStyle(color: Colors.white)),
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
