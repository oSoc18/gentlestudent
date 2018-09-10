import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

//This page displays the "AboutUs.txt" you can find in the assets folder
//To change the text that's displayed on this page, simply change the text in that document
class AboutUsPage extends StatefulWidget {
  //This tag allows us to navigate to the AboutUsPage
  static String tag = 'about-us-page';

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  //Declaration of the variables
  var aboutUsController;
  final String aboutUsLink = "assets/AboutUs.txt"; //This is the link to the "AboutUs.txt" file
  String aboutUs = "";

  //Constructor
  _AboutUsPageState() {
    aboutUsController = new TextEditingController();
  }

  //Function that returns the text of a given file
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

  //This method gets called when the page is disposing
  //We overwrite it to:
  // - Dispose of our controller
  @override
  void dispose() {
    aboutUsController.dispose();
    super.dispose();
  }

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load and display the text of the "AboutUs.txt" file
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
      body: new SingleChildScrollView(
        child: new Center(
          //HtmlView takes the text, interprets the HTML tags and then displays it
          child: new HtmlView(
            data: aboutUsController.text,
          ),
        ),
      ),
    );
  }
}
