import 'package:flutter/material.dart';

class MyLearningOpportunitiesPage extends StatefulWidget {
  static String tag = 'my-learning-opportunities-page';
  @override
  _MyLearningOpportunitiesPageState createState() =>
      _MyLearningOpportunitiesPageState();
}

class _MyLearningOpportunitiesPageState
    extends State<MyLearningOpportunitiesPage> {
  //@override
  //Widget build(BuildContext context) {
  //return Scaffold(
  //appBar: new AppBar(
  //title: new Text("Mijn leerkansen", style: TextStyle(color: Colors.white)),
  //iconTheme: new IconThemeData(color: Colors.white),
  //),
  //backgroundColor: Colors.white,
  //);
  //}

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: 2,
      child: new Scaffold(
        body: new NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              new SliverAppBar(
                title: const Text(
                  'Mijn leerkansen',
                  style: TextStyle(color: Colors.white),
                ),
                iconTheme: new IconThemeData(
                  color: Colors.white,
                ),
                forceElevated: innerBoxIsScrolled,
                pinned: true,
                floating: true,
                bottom: new TabBar(
                  labelColor: Colors.white,
                  tabs: <Tab>[
                    new Tab(text: 'Goedgekeurde'),
                    new Tab(text: 'Aangevraagde'),
                  ],
                ),
              ),
            ];
          },
          body: new TabBarView(
            children: <Widget>[
              new Center(
                child: new Container(
                  height: 1000.0,
                  color: Colors.green.shade200,
                  child: new Center(
                    child: new FlutterLogo(colors: Colors.green),
                  ),
                ),
              ),
              new Center(
                child: new Container(
                  height: 1000.0,
                  color: Colors.purple.shade200,
                  child: new Center(
                    child: new FlutterLogo(colors: Colors.purple),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
