import 'package:flutter/material.dart';

class StatementController {
  late TextEditingController textController;
  late TextEditingController dateController;
  late TextEditingController statementTypeController;
  late TextEditingController trueController;
  late TextEditingController labelController;
  late TextEditingController funnyController;
  late TextEditingController statementLinkController;
  late TextEditingController correctedController;
  late TextEditingController relevanceController;
  late TextEditingController authorController;
  late TextEditingController mediumController;

  StatementController(Map<String, dynamic> statement) {
    textController = TextEditingController(text: statement["text"]);
    dateController = TextEditingController(text: statement["date"]);
    statementTypeController =
        TextEditingController(text: statement["statementType"]);
    trueController =
        TextEditingController(text: statement["true"] ? "Fakt" : "Fake");
    labelController = TextEditingController(text: statement["label"]);
    funnyController =
        TextEditingController(text: statement["funny"] ? "Lustig" : "Ernst");
    statementLinkController =
        TextEditingController(text: statement["statementLink"]);
    correctedController = TextEditingController(
        text: statement["corrected"]
            ? "Wurde korrigiert"
            : "Wurde nicht korrigiert.");
    relevanceController = TextEditingController(text: statement["relevance"]);
    authorController = TextEditingController(text: statement["author"]);
    mediumController = TextEditingController(text: statement["medium"]);
  }

  void dispose() {
    textController.dispose();
    dateController.dispose();
    statementTypeController.dispose();
    trueController.dispose();
    labelController.dispose();
    funnyController.dispose();
    statementLinkController.dispose();
    correctedController.dispose();
    relevanceController.dispose();
    authorController.dispose();
    mediumController.dispose();
  }
}
