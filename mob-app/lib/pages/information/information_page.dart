import 'dart:async';

import 'package:Gentle_Student/pages/information/experiences/experiences_page.dart';
import 'package:Gentle_Student/pages/information/news/news_page.dart';
import 'package:Gentle_Student/pages/information/tutorial/tutorial_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

//This page allows navigation to all information related pages
class InformationPage extends StatelessWidget {
  //This tag allows us to navigate to the InformationPage
  static String tag = 'information-page';

  //Function for launching an url into a browser of a smartphone
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
      //List of all information related pages
      body: ListView(
        children: <Widget>[
          //Launch the Gentlestudent website
          Container(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Website'),
                onTap: () => _launchInBrowser("http://gentlestudent.gent"),
              ),
              decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide()))),

          //Navigate to the AboutUsPage
          Container(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Over ons'),
                onTap: () {
                  //Old "About us" page
                  //Navigator.of(context).pushNamed(AboutUsPage.tag);

                  //New website
                  //_launchInBrowser("http://gentlestudent.gent/overons");

                  //Old website
                  _launchInBrowser(
                      "https://gentle-student.firebaseapp.com/overons");
                },
              ),
              decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide()))),

          //Navigate to the TutorialPage
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

          //Navigate to the ExperiencesPage
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

          //Navigate to the NewsPage
          Container(
              child: ListTile(
                trailing: Icon(Icons.arrow_forward_ios),
                title: Text('Nieuws'),
                onTap: () {
                  Navigator.of(context).pushNamed(NewsPage.tag);
                },
              ),
              decoration: new BoxDecoration(
                  border: new Border(bottom: new BorderSide()))),

          //Navigate to the PrivacyPolicyPage
          Container(
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text('Privacybeleid & voorwaarden'),
              onTap: () {
                //Old "Privacy policy" page
                //Navigator.of(context).pushNamed(PrivacyPolicyPage.tag);

                //New website
                //_launchInBrowser("http://gentlestudent.gent/privacy");

                //Old website
                _launchInBrowser(
                    "https://gentle-student.firebaseapp.com/privacy");
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
