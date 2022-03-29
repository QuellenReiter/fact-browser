import 'dart:math';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;

class Utils {
  static String? checkIfEmpty(TextEditingController textEditingController) {
    final text = textEditingController.text;
    if (text.isEmpty) {
      return 'Kann nicht leer sein';
    }
    // return null if the text is valid
    return null;
  }

  static String? checkIfDay(TextEditingController textEditingController) {
    final text = textEditingController.text != ""
        ? int.parse(textEditingController.text)
        : 0;
    if (text > 31) {
      return 'Kein valider Tag.';
    }
    // return null if the text is valid
    return null;
  }

  static String? checkIfMonth(TextEditingController textEditingController) {
    final text = textEditingController.text != ""
        ? int.parse(textEditingController.text)
        : 0;
    if (text > 12) {
      return 'Kein valider Monat.';
    }
    // return null if the text is valid
    return null;
  }

  static String? checkIfYear(TextEditingController textEditingController) {
    final text = textEditingController.text != ""
        ? int.parse(textEditingController.text)
        : 0;
    if (text > DateTime.now().year) {
      return 'Keine Zeitreise bitte.';
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
      var temp = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: false);
      Uint8List? file = temp?.files.single.bytes;
      // resize the image to max 800 pix on largest side.
      img.Image tempFile = img.decodeImage(List.from(file!))!;
      tempFile = img.copyResize(
        tempFile,
        width: tempFile.height > tempFile.width ? -1 : 800,
        height: tempFile.height > tempFile.width ? 800 : -1,
      );
      // convert back to bytes
      callback(img.encodeJpg(tempFile, quality: 50));
    } else {
      return;
    }
  }

  static String formatDate(String? date) {
    if (date == null) {
      return "";
    }
    if (date.length < 10) {
      return "";
    }
    return date.substring(8, 10) +
        "/" +
        date.substring(5, 7) +
        "/" +
        date.substring(0, 4);
  }

  static String? toUTCDateFormat(String? date) {
    if (date == null) {
      return null;
    }
    if (date.length < 10) {
      return null;
    }
    var ret = DateTime.utc(
      int.parse(date.substring(6, 10)),
      int.parse(date.substring(3, 5)),
      int.parse(date.substring(0, 2)),
    );
    return ret.toString();
  }
}

class CorrectnessCategory {
  static String correct = "richtig";
  static String unverified = "unbelegt";
  static String falseContext = "falscher Kontext";
  static String manipulated = "manipuliert";
  static String misleading = "irreführend";
  static String fabricatedContent = "frei erfunden";
  static String falseInformation = "Fehlinformation";
  static String satire = "Satire";
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
