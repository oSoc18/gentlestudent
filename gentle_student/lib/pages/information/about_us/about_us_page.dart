import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class AboutUsPage extends StatefulWidget {
  //Tag for navigation
  static String tag = 'about-us-page';
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  //Declaration of the variables
  var aboutUsController;
  final String aboutUsLink = "assets/AboutUs.txt";
  String aboutUs = "";

  //Constructor
  _AboutUsPageState() {
    aboutUsController = new TextEditingController();
  }

  //Function that returns the text of a file
  Future<String> getAboutUs(String path) async {
    return await rootBundle.loadString(path);
  }

  //Function for displaying the text
  void displayAboutUs() async {
    aboutUs = await getAboutUs(aboutUsLink);
    setState(() {
      aboutUsController.text = aboutUs;
    });
  }

  //We need to dispose of our controller
  @override
  void dispose() {
    aboutUsController.dispose();
    super.dispose();
  }

  //When this page is initialized, we want to display the text
  @override
  void initState() {
    super.initState();
    displayAboutUs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Over ons", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: new SingleChildScrollView(
          child: new Center(
          //HtmlView takes the text, interprets the HTML tags and then displays it
            child: new HtmlView(data: aboutUsController.text,),
          ),
        ),
    );
  }
}