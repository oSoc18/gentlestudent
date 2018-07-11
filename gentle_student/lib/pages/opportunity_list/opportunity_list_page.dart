import 'dart:async';
import 'package:Gentle_Student/data/api.dart';
import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:Gentle_Student/pages/opportunity_details/opportunity_details_page.dart';
import 'package:flutter/material.dart';

class OpportunityListPage extends StatefulWidget {
  static String tag = 'opportunity-list-page';
  @override
  _OpportunityListPageState createState() => _OpportunityListPageState();
}

class _OpportunityListPageState extends State<OpportunityListPage> {
  List<Opportunity> _opportunities = [];
  OpportunityApi _api;

  @override
  void initState() {
    super.initState();
    _loadFromFirebase();
  }

  _loadFromFirebase() async {
    final api = new OpportunityApi();
    final opportunities = await api.getAllOpportunities();
    setState(() {
      _api = api;
      _opportunities = opportunities;
    });
  }

  _reloadOpportunities() async {
    if (_api != null) {
      final opportunities = await _api.getAllOpportunities();
      setState(() {
        _opportunities = opportunities;
      });
    }
  }

  _navigateToOpportunityDetails(Opportunity opportunity) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (BuildContext context) =>
                new OpportunityDetailsPage(opportunity)));
  }

  Widget _buildOpportunityItem(BuildContext context, int index) {
    Opportunity opportunity = _opportunities[index];

    return new Container(
      margin: const EdgeInsets.only(top: 3.0),
      child: new Card(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new ListTile(
              onTap: () {
                _navigateToOpportunityDetails(opportunity);
              },
              leading: new Hero(
                tag: index,
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(opportunity.badgeImageUrl), radius: 40.0,
                ),
              ),
              title: new Text(
                opportunity.name,
                style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 21.0),
              ),
              subtitle: new Text(_getCategory(opportunity) +
                  " - " +
                  _getDifficulty(opportunity) +
                  "\n" +
                  opportunity.issuerName),
              isThreeLine: true,
              dense: false,
            ),
          ],
        ),
      ),
    );
  }

  String _getDifficulty(Opportunity opportunity) {
    switch (opportunity.difficulty) {
      case Difficulty.BEGINNER:
        return "Niveau 1";
      case Difficulty.INTERMEDIATE:
        return "Niveau 2";
      case Difficulty.EXPERT:
        return "Niveau 3";
    }
    return "Niveau 0";
  }

  String _getCategory(Opportunity opportunity) {
    switch (opportunity.category) {
      case Category.DIGITALEGELETTERDHEID:
        return "Digitale geletterdheid";
      case Category.DUURZAAMHEID:
        return "Duurzaamheid";
      case Category.ONDERNEMERSSCHAP:
        return "Ondernemersschap";
      case Category.ONDERZOEK:
        return "Onderzoek";
      case Category.WERELDBURGERSCHAP:
        return "Wereldburgerschap";
    }
    return "Algemeen";
  }

  Future<Null> refresh() {
    _reloadOpportunities();
    return new Future<Null>.value();
  }

  Widget _getListViewWidget() {
    return new Flexible(
      child: new RefreshIndicator(
        onRefresh: refresh,
        child: new ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: _opportunities.length,
            itemBuilder: _buildOpportunityItem),
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