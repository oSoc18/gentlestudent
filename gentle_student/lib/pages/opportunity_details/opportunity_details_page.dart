import 'package:Gentle_Student/models/category.dart';
import 'package:Gentle_Student/models/difficulty.dart';
import 'package:Gentle_Student/models/opportunity.dart';
import 'package:flutter/material.dart';

class OpportunityDetailsPage extends StatelessWidget {
  final Opportunity opportunity;

  OpportunityDetailsPage(this.opportunity);

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
      case Category.ONDERNEMINGSZIN:
        return "Ondernemingszin";
      case Category.ONDERZOEK:
        return "Onderzoek";
      case Category.WERELDBURGERSCHAP:
        return "Wereldburgerschap";
    }
    return "Algemeen";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doe mee!", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            SizedBox(height: 8.0),
            new Text("LeerkansId: " + opportunity.opportunityId.toString()),
            SizedBox(height: 8.0),
            new Text("Naam: " + opportunity.name),
            SizedBox(height: 8.0),
            new Text("Moeilijkheid: " + _getDifficulty(opportunity)),
            SizedBox(height: 8.0),
            new Text("Categorie: " + _getCategory(opportunity)),
            SizedBox(height: 8.0),
            new Text("Issuer: " + opportunity.issuerName),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}