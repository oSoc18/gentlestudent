import 'dart:async';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter_html_view/flutter_html_view.dart';

class PrivacyPolicyPage extends StatefulWidget {
  static String tag = 'privacy-policy-page';
  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  var privacyPolicyController;
  final String privacyPolicyLink = "assets/PrivacyPolicy.txt";
  String privacyPolicy = "";

  _PrivacyPolicyPageState() {
    privacyPolicyController = new TextEditingController();
  }

  Future<String> getPrivacyPolicy(String path) async {
    return await rootBundle.loadString(path);
  }

  void displayPrivacyPolicy() async {
    privacyPolicy = await getPrivacyPolicy(privacyPolicyLink);
    setState(() {
      privacyPolicyController.text = privacyPolicy;
    });
  }

  @override
  void dispose() {
    privacyPolicyController.dispose();
    super.dispose();
  }

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
      backgroundColor: Colors.white,
      body: new SingleChildScrollView(
          child: new Center(
            child: new HtmlView(data: privacyPolicyController.text,),
          ),
        ),
    );
  }
}
