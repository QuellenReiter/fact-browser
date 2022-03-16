import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/utilities/utilities.dart';

class StatementController {
  late TextEditingController textController;
  late TextEditingController dateController;
  late TextEditingController mediaTypeController;
  late TextEditingController correctnessController;
  late TextEditingController categoryController;
  late TextEditingController samplePictureCopyrightController;
  late TextEditingController linkController;
  late TextEditingController authorController;
  late TextEditingController mediaController;
  late TextEditingController languageController;

  StatementController.fromMap(Map<String, dynamic> statement) {
    textController =
        TextEditingController(text: statement[Queries.statementText]);
    dateController =
        TextEditingController(text: statement[Queries.statementDate]);
    mediaTypeController =
        TextEditingController(text: statement[Queries.statementMediatype]);
    correctnessController =
        TextEditingController(text: statement[Queries.statementCorrectness]);
    categoryController =
        TextEditingController(text: statement[Queries.statementCategory]);
    samplePictureCopyrightController = TextEditingController(
        text: statement[Queries.statementPictureCopyright]);
    linkController =
        TextEditingController(text: statement[Queries.statementLink]);
    authorController =
        TextEditingController(text: statement[Queries.statementAuthor]);
    mediaController =
        TextEditingController(text: statement[Queries.statementMedia]);
  }

  StatementController(Statement statement) {
    textController = TextEditingController(text: statement.statementText);
    textController.addListener(() {
      statement.statementText = textController.text;
    });
    dateController = TextEditingController(text: statement.statementDate);
    dateController.addListener(() {
      statement.statementDate = dateController.text;
    });
    mediaTypeController =
        TextEditingController(text: statement.statementMediatype);
    mediaTypeController.addListener(() {
      statement.statementMediatype = mediaTypeController.text;
    });
    correctnessController =
        TextEditingController(text: statement.statementCorrectness);
    correctnessController.addListener(() {
      statement.statementCorrectness = correctnessController.text;
    });
    categoryController =
        TextEditingController(text: statement.statementCategory);
    categoryController.addListener(() {
      statement.statementCategory = categoryController.text;
    });
    linkController = TextEditingController(text: statement.statementLink);
    linkController.addListener(() {
      statement.statementLink = linkController.text;
    });
    samplePictureCopyrightController =
        TextEditingController(text: statement.samplePictureCopyright);
    samplePictureCopyrightController.addListener(() {
      statement.samplePictureCopyright = samplePictureCopyrightController.text;
    });
    authorController = TextEditingController(text: statement.statementAuthor);
    authorController.addListener(() {
      statement.statementAuthor = authorController.text;
    });
    mediaController = TextEditingController(text: statement.statementMedia);
    mediaController.addListener(() {
      statement.statementMedia = mediaController.text;
    });
    languageController =
        TextEditingController(text: statement.statementLanguage);
    languageController.addListener(() {
      statement.statementLanguage = languageController.text;
    });
  }

  void dispose() {
    textController.dispose();
    dateController.dispose();
    mediaTypeController.dispose();
    correctnessController.dispose();
    categoryController.dispose();
    samplePictureCopyrightController.dispose();
    linkController.dispose();
    authorController.dispose();
    mediaController.dispose();
  }
}

class Statement {
  late String statementText;
  late String statementPictureURL;
  late String statementDate;
  late String statementMediatype;
  late String statementLanguage;
  late String statementCorrectness;
  late String statementLink;
  late bool statementRectification;
  late String statementCategory;
  late String samplePictureCopyright;
  late String statementAuthor;
  late String statementMedia;
  late Facts statementFactchecks;
  Uint8List? uploadImage;
  String? objectId;
  Statement(
      this.statementText,
      this.statementAuthor,
      this.statementCategory,
      this.statementCorrectness,
      this.statementDate,
      this.statementFactchecks,
      this.statementLanguage,
      this.statementLink,
      this.statementMedia,
      this.statementMediatype,
      this.statementPictureURL,
      this.samplePictureCopyright,
      this.statementRectification);

  Statement.fromMap(Map<String, dynamic>? map)
      : statementText = map?[Queries.statementText],
        statementAuthor = map?[Queries.statementAuthor],
        statementCorrectness = map?[Queries.statementCorrectness],
        statementDate = Utils.formatDate(map?[Queries.statementDate]),
        statementLanguage = map?[Queries.statementLanguage],
        statementLink = map?[Queries.statementLink],
        statementCategory = map?[Queries.statementCategory],
        statementMedia = map?[Queries.statementMedia],
        statementMediatype = map?[Queries.statementMediatype],
        samplePictureCopyright = map?[Queries.statementPictureCopyright],
        statementRectification = map?[Queries.statementRectification],
        statementPictureURL = map?[Queries.statementPicture]["url"],
        statementFactchecks =
            Facts.fromMap(map?[Queries.statementFactcheckIDs]);

  Statement.empty() {
    statementText = "";
    statementAuthor = "";
    statementCategory = Queries.categoryValues.first;
    statementCorrectness = Queries.correctnessValues.first;
    statementDate = "";
    statementFactchecks = Facts();
    statementLanguage = "";
    statementLink = "";
    statementMedia = "";
    statementMediatype = Queries.mediatypeValues.first;
    statementPictureURL = "";
    samplePictureCopyright = "";
    statementRectification = false;
  }
}

class Statements {
  List<Statement> statements = [];

  Statements.fromMap(Map<String, dynamic>? map) {
    for (Map<String, dynamic>? statement in map?["statements"]["edges"]) {
      statements.add(Statement.fromMap(statement?["node"]));
    }
  }
}
