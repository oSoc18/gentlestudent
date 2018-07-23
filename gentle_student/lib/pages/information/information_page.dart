import 'dart:async';

import 'package:Gentle_Student/pages/information/about_us/about_us_page.dart';
import 'package:Gentle_Student/pages/information/experiences/experiences_page.dart';
import 'package:Gentle_Student/pages/information/privacy_policy/privacy_policy_page.dart';
import 'package:Gentle_Student/pages/information/tutorial/tutorial_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatelessWidget {
  static String tag = 'information-page';

  Future<Null> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Informatie", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Website'),
                onTap: () => _launchInBrowser("http://gentlestudent.gent"),
              ),
              decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide()))),
          Container(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Over ons'),
                onTap: () {
                  Navigator.of(context).pushNamed(AboutUsPage.tag);
                },
              ),
              decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide()))),
          Container(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Tutorial'),
                onTap: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (BuildContext context) =>
                          new TutorialPage(false),
                    ),
                  );
                },
              ),
              decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide()))),
          Container(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Ervaringen'),
                onTap: () {
                  Navigator.of(context).pushNamed(ExperiencesPage.tag);
                },
              ),
              decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide()))),
          Container(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Nieuws'),
                onTap: () {
                  //Navigator.of(context).pushNamed(AboutUsPage.tag);
                },
              ),
              decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide()))),
          Container(
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Privacybeleid & voorwaarden'),
              onTap: () {
                Navigator.of(context).pushNamed(PrivacyPolicyPage.tag);
              },
            ),
            decoration: new BoxDecoration(
              border: new Border(
                bottom: new BorderSide(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
