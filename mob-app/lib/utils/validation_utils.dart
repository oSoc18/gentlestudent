import 'package:flutter/material.dart';

class ValidationUtils {
  static bool allFieldsFilledIn(List<TextEditingController> fields) {
    if (fields.length == 0) return false;
    for (var field in fields) {
      if (field.text == "" || field.text == null || field == null) return false;
    }
    return true;
  }
}
