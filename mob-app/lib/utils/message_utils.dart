import 'package:flutter/material.dart';

class MessageUtils {
  static void showSnackBar(GlobalKey<ScaffoldState> key, String text) {
    key.currentState.showSnackBar(
      new SnackBar(
        content: new Text(text),
        duration: Duration(seconds: 4),
      ),
    );
  }
}
