import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

//This page displays the "PrivacyPolicy.txt" you can find in the assets folder
//To change the text that's displayed on this page, simply change the text in that document
class PrivacyPolicyPage extends StatefulWidget {
  //This tag allows us to navigate to the PrivacyPolicyPage
  static String tag = 'privacy-policy-page';

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  //Declaration of the variables
  var privacyPolicyController;
  final String privacyPolicyLink = "assets/PrivacyPolicy.txt"; //This is the link to the "PrivacyPolicy.txt" file
  String privacyPolicy = "";

  //Constructor
  _PrivacyPolicyPageState() {
    privacyPolicyController = new TextEditingController();
  }

  //Function that returns the text of a given file
  Future<String> getPrivacyPolicy(String path) async {
    return await rootBundle.loadString(path);
  }

  //Function for displaying the text
  void displayPrivacyPolicy() async {
    privacyPolicy = await getPrivacyPolicy(privacyPolicyLink);
    setState(() {
      privacyPolicyController.text = privacyPolicy;
    });
  }

  //This method gets called when the page is disposing
  //We overwrite it to:
  // - Dispose of our controller
  @override
  void dispose() {
    privacyPolicyController.dispose();
    super.dispose();
  }

  //This method gets called when the page is initializing
  //We overwrite it to:
  // - Load and display the text of the "PrivacyPolicy.txt" file
  @override
  void initState() {
    super.initState();
    displayPrivacyPolicy();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Privacybeleid & voorwaarden", style: TextStyle(color: Colors.white)),
        iconTheme: new IconThemeData(color: Colors.white),
      ),
      body: new SingleChildScrollView(
          child: new Center(
            //HtmlView takes the text, interprets the HTML tags and then displays it
            child: new HtmlView(data: privacyPolicyController.text,),
          ),
        ),
    );
  }
}
