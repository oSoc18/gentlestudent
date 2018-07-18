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
  IconData appBarIcon = Icons.list;
  String appBarIconTooltip =
      "Klik hier om naar de lijst van leerkansen te gaan";

  _toggleBetweenPages() {
    if (appBarTitle == "Map") {
      setState(() {
        currentTab = 1;
        currentPage = pages[currentTab];
        appBarTitle = "Leerkansen";
        appBarButton = "MAP";

        appBarIcon = Icons.map;
        appBarIconTooltip = "Klik hier om naar de map met leerkansen te gaan";
      });
    } else {
      setState(() {
        currentTab = 0;
        currentPage = pages[currentTab];
        appBarTitle = "Map";
        appBarButton = "LIJST";

        appBarIcon = Icons.list;
        appBarIconTooltip = "Klik hier om naar de lijst van leerkansen te gaan";
      });
    }
  }

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
        // Change pages with text:
        // new FlatButton(
        //   child: Text(
        //     appBarButton,
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontFamily: "Roboto",
        //     ),
        //   ),
        //   padding: EdgeInsets.all(0.0),
        //   onPressed: _toggleBetweenPages,
        // ),

        // Change pages with icon button:
        IconButton(
          icon: Icon(
            appBarIcon,
          ),
          onPressed: _toggleBetweenPages,
          tooltip: appBarIconTooltip,
        ),
      ],
    );

    return new Scaffold(
      appBar: customAppBar,
      body: currentPage,
    );
  }
}
