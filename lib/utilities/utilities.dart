import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  static String formatDate(String date){
        return date.substring(8,10) + "/" + date.substring(5,7) + "/" + date.substring(0,4);
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


// Source: https://stackoverflow.com/questions/47403758/flutter-inputformatter-for-date 
class DateTextFormatter extends TextInputFormatter {
  static const _maxChars = 8;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    var text = _format(newValue.text, '/');
    return newValue.copyWith(text: text, selection: updateCursorPosition(text));
  }

  String _format(String value, String seperator) {
    value = value.replaceAll(seperator, '');
    var newString = '';
    for (int i = 0; i < min(value.length, _maxChars); i++) {
      newString += value[i];
      if ((i == 1 || i == 3) && i != value.length - 1) {
        newString += seperator;
      }
    }

    return newString;
  }

  TextSelection updateCursorPosition(String text) {
    return TextSelection.fromPosition(TextPosition(offset: text.length));
  }
}

