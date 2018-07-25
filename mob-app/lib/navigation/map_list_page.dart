import 'package:Gentle_Student/pages/map/map_page.dart';
import 'package:Gentle_Student/pages/opportunity_list/opportunity_list_page.dart';
import 'package:flutter/material.dart';

//This page is used to switch between the map view and the list view of the opportunities
//As you may have guessed, it contains the MapPage and OpportunityListPage
//The state of this page may change so that's why we use a StatefulWidget
class MapListPage extends StatefulWidget {
  //This tag allows us to navigate to the MapListPage
  static String tag = 'map-list-page';

  @override
  _MapListPageState createState() => _MapListPageState();
}

class _MapListPageState extends State<MapListPage> {
  //Variables used for navigation (see HomePage for more information)
  int currentTab = 0;
  MapPage mapPage = new MapPage();
  OpportunityListPage opportunityListPage = new OpportunityListPage();
  List<Widget> pages;
  Widget currentPage;

  //Declaration of the other variables
  String appBarTitle = "Map";
  String appBarButton = "LIJST";
  IconData appBarIcon = Icons.list;
  String appBarIconTooltip =
      "Klik hier om naar de lijst van leerkansen te gaan";

  //Changing between the list view and the map view
  _toggleBetweenPages() {
    if (appBarTitle == "Map") {
      //What happens when you're on the MapPage
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
        //What happens when you're on the OpportunityListPage
        currentTab = 0;
        currentPage = pages[currentTab];
        appBarTitle = "Map";
        appBarButton = "LIJST";

        appBarIcon = Icons.list;
        appBarIconTooltip = "Klik hier om naar de lijst van leerkansen te gaan";
      });
    }
  }

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load pages and the current page for navigation
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
        // Change pages with text button:

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
