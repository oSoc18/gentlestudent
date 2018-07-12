import 'package:flutter/material.dart';

class MyLearningOpportunitiesPage extends StatefulWidget {
  static String tag = 'my-learning-opportunities-page';
  @override
  _MyLearningOpportunitiesPageState createState() => _MyLearningOpportunitiesPageState();
}

class _MyLearningOpportunitiesPageState extends State<MyLearningOpportunitiesPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Mijn leerkansen", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
    );
  }
}
