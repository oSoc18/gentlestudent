import 'package:Gentle_Student/viewmodels/opportunity_viewmodel.dart';
import 'package:Gentle_Student/views/pages/opportunities/map_page.dart';
import 'package:Gentle_Student/views/pages/opportunities/opportunity_list_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class MapListPage extends StatefulWidget {
  static String tag = 'map-list-page';

  @override
  _MapListPageState createState() => _MapListPageState();
}

class _MapListPageState extends State<MapListPage> {
  OpportunityViewModel viewModel = new OpportunityViewModel();
  List<Widget> pages = [new MapPage(), new OpportunityListPage()];
  int currentTab = 0;
  Widget currentPage;
  String appBarTitle = "Map";
  IconData appBarIcon = Icons.list;
  String appBarIconTooltip =
      "Klik hier om naar de lijst van leerkansen te gaan";

  _toggleBetweenPages() {
    if (appBarTitle == "Map") {
      setState(() {
        currentTab = 1;
        currentPage = pages[currentTab];
        appBarTitle = "Leerkansen";
        appBarIcon = Icons.map;
        appBarIconTooltip = "Klik hier om naar de map met leerkansen te gaan";
      });
    } else {
      setState(() {
        currentTab = 0;
        currentPage = pages[currentTab];
        appBarTitle = "Map";
        appBarIcon = Icons.list;
        appBarIconTooltip = "Klik hier om naar de lijst van leerkansen te gaan";
      });
    }
  }

  Future _loadData() async {
    await viewModel.fetchOpportunities();
    await viewModel.fetchBadges();
    await viewModel.fetchIssuers();
    await viewModel.fetchAddresses();
  }

  @override
  void initState() {
    super.initState();
    currentPage = pages[currentTab];
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final AppBar customAppBar = new AppBar(
      title: Text(appBarTitle, style: TextStyle(color: Colors.white)),
      iconTheme: new IconThemeData(color: Colors.white),
      actions: <Widget>[
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
      body: ScopedModel<OpportunityViewModel>(
        model: viewModel,
        child: currentPage,
      ),
    );
  }
}
