import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
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

  static void pickFile(Function callback) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        Uint8List? file = (await FilePicker.platform.pickFiles(
          type: FileType.image,
          allowMultiple: false
        ))?.files.single.bytes;
        callback(file);
    } else {
      return;
    }
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
