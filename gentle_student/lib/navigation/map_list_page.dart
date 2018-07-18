import 'package:Gentle_Student/pages/map/map_page.dart';
import 'package:Gentle_Student/pages/opportunity_list/opportunity_list_page.dart';
import 'package:flutter/material.dart';

class MapListPage extends StatefulWidget {
  static String tag = 'map-list-page';
  @override
  _MapListPageState createState() => _MapListPageState();
}

class _MapListPageState extends State<MapListPage> {
  int currentTab = 0;
  MapPage mapPage = new MapPage();
  OpportunityListPage opportunityListPage = new OpportunityListPage();
  List<Widget> pages;
  Widget currentPage;

  String appBarTitle = "Map";
  String appBarButton = "LIJST";

  @override
  void initState() {
    super.initState();
    pages = [mapPage, opportunityListPage];
    currentPage = mapPage;
  }

  @override
  Widget build(BuildContext context) {
    final AppBar customAppBar = new AppBar(
      title: Text(appBarTitle, style: TextStyle(color: Colors.white)),
      iconTheme: new IconThemeData(color: Colors.white),
      actions: <Widget>[
        new FlatButton(
          child: Text(
            appBarButton,
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            if (appBarTitle == "Map") {
              setState(() {
                currentTab = 1;
                currentPage = pages[currentTab];
                appBarTitle = "Leerkansen";
                appBarButton = "MAP";
              });
            } else {
              setState(() {
                currentTab = 0;
                currentPage = pages[currentTab];
                appBarTitle = "Map";
                appBarButton = "LIJST";
              });
            }
          },
        ),
      ],
    );

    return new Scaffold(
      appBar: customAppBar,
      body: currentPage,
    );
  }
}
