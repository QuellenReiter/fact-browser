import 'dart:io';
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
  late TextEditingController relevanceController;
  late TextEditingController authorController;
  late TextEditingController mediaController;
  late TextEditingController languageController;


  StatementController.fromMap(Map<String, dynamic> statement) {
    textController = TextEditingController(text: statement["text"]);
    dateController = TextEditingController(text: statement["date"]);
    mediaTypeController =
        TextEditingController(text: statement["statementType"]);
    correctnessController =
        TextEditingController(text: statement["true"] ? "Fakt" : "Fake");
    categoryController = TextEditingController(text: statement["label"]);
    samplePictureCopyrightController =
        TextEditingController(text: statement["funny"] ? "Lustig" : "Ernst");
    linkController =
        TextEditingController(text: statement["statementLink"]);
    relevanceController = TextEditingController(text: statement["relevance"]);
    authorController = TextEditingController(text: statement["author"]);
    mediaController = TextEditingController(text: statement["medium"]);
  }

  StatementController(Statement statement){
    textController = TextEditingController(text: statement.statementText);
    // add date conversion functions
    dateController = TextEditingController(text: statement.statementDate);
    mediaTypeController =
        TextEditingController(text: statement.statementMediatype);
    correctnessController =
        TextEditingController(text: statement.statementCorrectness);
    categoryController = TextEditingController(text: statement.statementCategory);
    linkController =
        TextEditingController(text: statement.statementLink);
    samplePictureCopyrightController = TextEditingController(
        text: statement.samplePictureCopyright);
    authorController = TextEditingController(text: statement.statementAuthor);
    mediaController = TextEditingController(text: statement.statementMedia);
    languageController = TextEditingController(text: statement.statementLanguage);
  }

  void dispose() {
    textController.dispose();
    dateController.dispose();
    mediaTypeController.dispose();
    correctnessController.dispose();
    categoryController.dispose();
    samplePictureCopyrightController.dispose();
    linkController.dispose();
    relevanceController.dispose();
    authorController.dispose();
    mediaController.dispose();
  }
}

class Statement{
  String statementText;
  String statementPictureURL;
  String statementDate;
  String statementMediatype;
  String statementLanguage;
  String statementCorrectness;
  String statementLink;
  bool statementRectification;
  String statementCategory;
  String samplePictureCopyright;
  String statementAuthor;
  String statementMedia;
  Facts statementFactchecks;
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

    Statement.fromMap(Map<String, dynamic>? map) : 
      statementText = map?[Queries.statementText],
      statementAuthor = map?[Queries.statementAuthor],
      statementCorrectness = map?[Queries.statementCorrectness],
      statementDate = map?[Queries.statementDate],
      statementLanguage = map?[Queries.statementLanguage],
      statementLink = map?[Queries.statementLink],
      statementCategory = map?[Queries.statementCategory],
      statementMedia = map?[Queries.statementMedia],
      statementMediatype = map?[Queries.statementMediatype],
      samplePictureCopyright = map?[Queries.statementPictureCopyright],
      statementRectification = map?[Queries.statementRectification],
      statementPictureURL = map?[Queries.statementPicture]["url"],
      statementFactchecks = Facts.fromMap(map?[Queries.statementFactcheckIDs]);
}

class Statements{
  List<Statement> statements = [];

  Statements.fromMap(Map<String, dynamic>? map){
    for(Map<String, dynamic>? statement in map?["statements"]["edges"]){
      statements.add(Statement.fromMap(statement?["node"]));
    }
  } 
}