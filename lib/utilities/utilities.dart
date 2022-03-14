import 'package:flutter/material.dart';

class Utils {
  static String? checkIfEmpty(TextEditingController textEditingController) {
    final text = textEditingController.text;
    if (text.isEmpty) {
      return 'Kann nicht leer sein';
    }
    // return null if the text is valid
    return null;
  }

  static String? checkIfLongerThan(
      TextEditingController textEditingController, int minLength) {
    final text = textEditingController.text;
    if (text.length < minLength) {
      return 'Mindestens ${minLength.toString()} Zeichen';
    }
    // return null if the text is valid
    return null;
  }

  static String? checkIfEmptyOrEqualTo(
      TextEditingController textEditingController, String compareString) {
    final text = textEditingController.text;
    if (text == compareString) {
      return 'Text ist unverändert';
    }
    // return null if the text is valid
    return null;
  }
}

class CorrectnessCategory{
  static String correct = "richtig";
  static String unverified = "unbelegt";
  static String falseContext = "falscher Kontext";
  static String manipulated = "manipuliert";
  static String misleading = "irreführend";
  static String fabricatedContent = "frei erfunden";
  static String falseInformation = "Fehlinformation";
}
