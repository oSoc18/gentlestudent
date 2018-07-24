import 'package:Gentle_Student/models/experience.dart';
import 'package:flutter/material.dart';

class ExperienceDetailsPage extends StatelessWidget {
  final Experience experience;

  ExperienceDetailsPage(this.experience);

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

          ],
        ),
      ),
    );
  }
}