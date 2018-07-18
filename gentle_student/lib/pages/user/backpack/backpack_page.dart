import 'dart:async';

import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/badge.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/user.dart';
import 'package:Gentle_Student/models/user_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackPackPage extends StatefulWidget {
  static String tag = 'backpack-page';
  @override
  _BackPackPageState createState() => _BackPackPageState();
}

class _BackPackPageState extends State<BackPackPage> {
  List<Badge> _badges = [];
  BadgeApi _api;

  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

  _loadFromFirebase() async {
    BadgeApi api = new BadgeApi();
    final badges = await api.getAllBadges();
    setState(() {
      _api = api;
      _badges = badges;
    });
  }

  _reloadBadges() async {
    if (_api != null) {
      final badges = await _api.getAllBadges();
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

// BadgeItem builder for svgs
  // Widget _buildBadgeItem(BuildContext context, int index) {
  //   Badge badge = _badges[index];
  //   final Widget svg = new SvgPicture.network(
  //     badge.image,
  //     height: 60.0,
  //     width: 60.0,
  //     placeholderBuilder: (BuildContext context) => new Container(
  //       padding: const EdgeInsets.all(30.0),
  //       child: const CircularProgressIndicator()),
  //   );
  //   return Column(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         svg
  //       ],
  //   );
  // }

  Widget _buildBadgeItem(BuildContext context, int index) {
    Badge badge = _badges[index];
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          new CircleAvatar(
                  backgroundImage: new NetworkImage(badge.image), radius: 40.0,
                )
        ],
    );
  }

  Future<Null> refresh() {
    _reloadBadges();
    return new Future<Null>.value();
  }

  Widget _getGridViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new GridView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _badges.length,
            gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemBuilder: _buildBadgeItem),
      ),
    );
  }

  List<Widget> _getBannerContent() {
    if(_badges.length>1){
      return [
        new Expanded(
          child: new Align(
            alignment: FractionalOffset.bottomCenter,
            child: new Text(
              "Zeer goed!",
              style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
        new Expanded(
          child: new Center(
            child: new Text(
              "Je hebt in totaal ${_badges.length.toString()} badges verdiend.",
              style: new TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          )
        ),
      ];
    }
    return [
      new Expanded(
        child: new Center(
          child: new Text(
            "Je hebt nog geen badges verdiend.",
            style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
          )
        )
      ),
    ];
  }

  Widget _getBannerWidget() {
    return new Flexible(
      child: new Container(
        decoration: new BoxDecoration(color: Colors.grey),
        child: new ConstrainedBox(
          constraints: const BoxConstraints.expand(
            height: 100.0
          ),
          child: new Center(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _getBannerContent()
            )
          )
        ),
      )
    );
  }

  Widget _buildBody() {
    return new Container(
      margin: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
      child: new Column(
        children: <Widget>[_getBannerWidget(),_getGridViewWidget()],
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

_getBannerWidget() {
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
