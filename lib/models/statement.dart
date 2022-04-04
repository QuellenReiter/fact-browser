import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/utilities/utilities.dart';

class StatementController {
  late TextEditingController textController;
  late TextEditingController yearController;
  late TextEditingController monthController;
  late TextEditingController dayController;
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
    yearController =
        TextEditingController(text: statement[Queries.statementYear]);
    monthController =
        TextEditingController(text: statement[Queries.statementYear]);
    dayController =
        TextEditingController(text: statement[Queries.statementYear]);
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
    yearController =
        TextEditingController(text: statement.statementYear.toString());
    yearController.addListener(() {
      statement.statementYear =
          yearController.text == "" ? 0 : int.parse(yearController.text);
    });
    monthController =
        TextEditingController(text: statement.statementMonth.toString());
    monthController.addListener(() {
      statement.statementMonth =
          monthController.text == "" ? 0 : int.parse(monthController.text);
    });
    dayController =
        TextEditingController(text: statement.statementDay.toString());
    dayController.addListener(() {
      statement.statementDay =
          dayController.text == "" ? 0 : int.parse(dayController.text);
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
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
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
  late int statementYear;
  late int statementMonth;
  late int statementDay;
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
      this.statementYear,
      this.statementMonth,
      this.statementDay,
      this.statementFactchecks,
      this.statementLanguage,
      this.statementLink,
      this.statementMedia,
      this.statementMediatype,
      this.statementPictureURL,
      this.samplePictureCopyright,
      this.statementRectification,
      this.objectId);

  Statement.fromMap(Map<String, dynamic>? map)
      : statementText = map?[Queries.statementText],
        statementAuthor = map?[Queries.statementAuthor],
        statementCorrectness = map?[Queries.statementCorrectness],
        statementYear = map?[Queries.statementYear],
        statementMonth = map?[Queries.statementMonth],
        statementDay = map?[Queries.statementDay],
        statementLanguage = map?[Queries.statementLanguage],
        statementLink = map?[Queries.statementLink],
        statementCategory = map?[Queries.statementCategory],
        statementMedia = map?[Queries.statementMedia],
        statementMediatype = map?[Queries.statementMediatype],
        samplePictureCopyright = map?[Queries.statementPictureCopyright],
        statementRectification = map?[Queries.statementRectification],
        statementPictureURL = map?[Queries.statementPictureFile]["url"],
        statementFactchecks =
            Facts.fromMap(map?[Queries.statementFactcheckIDs]),
        objectId = map?["objectId"];

  Statement.empty() {
    statementText = "";
    statementAuthor = "";
    statementCategory = Queries.categoryValues.first;
    statementCorrectness = Queries.correctnessValues.first;
    statementYear = 0;
    statementMonth = 0;
    statementDay = 0;
    statementFactchecks = Facts();
    statementLanguage = "";
    statementLink = "";
    statementMedia = "";
    statementMediatype = Queries.mediatypeValues.first;
    statementPictureURL = "emptyButNotEmpty";
    samplePictureCopyright = "";
    statementRectification = false;
  }
  // are all variables filled ?
  bool isComplete() {
    //check statement
    if (statementText.isEmpty ||
        statementAuthor.isEmpty ||
        statementCategory.isEmpty ||
        statementCorrectness.isEmpty ||
        statementLanguage.isEmpty ||
        statementLink.isEmpty ||
        statementMedia.isEmpty ||
        statementMediatype.isEmpty ||
        (statementPictureURL == "emptyButNotEmpty" && (uploadImage == null))) {
      return false;
    }
    //checl all facts
    for (var fact in statementFactchecks.facts) {
      if (fact.factAuthor.isEmpty ||
          fact.factLanguage.isEmpty ||
          fact.factLink.isEmpty ||
          fact.factMedia.isEmpty ||
          fact.factText.isEmpty) {
        return false;
      }
    }
    return true;
  }

  String dateAsString() {
    String ret = "";
    if (statementDay != 0) {
      ret += statementDay.toString().padLeft(2) + '/';
    }
    if (statementMonth != 0) {
      ret += statementMonth.toString().padLeft(2) + '/';
    }
    if (statementYear != 0) {
      ret += statementYear.toString();
    }
    return ret;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> vars = {
      "fields": {
        Queries.statementText: statementText,
        Queries.statementPicture: statementPictureURL,
        Queries.statementYear: statementYear,
        Queries.statementMonth: statementMonth,
        Queries.statementDay: statementDay,
        Queries.statementCorrectness: statementCorrectness,
        Queries.statementMedia: statementMedia,
        Queries.statementLanguage: statementLanguage,
        Queries.statementCategory: statementCategory,
        Queries.statementMediatype: statementMediatype,
        Queries.statementAuthor: statementAuthor,
        Queries.statementLink: statementLink,
        Queries.statementRectification: statementRectification,
        Queries.statementPictureCopyright: samplePictureCopyright,
        // Queries.statementPictureFile: {"file": statementPictureURL}
      }
    };

    if (uploadImage != null) {
      MultipartFile multipartFile = MultipartFile.fromBytes(
        Queries.statementPicture,
        uploadImage!.toList(),
        filename: '${DateTime.now().second}.jpg',
        contentType: MediaType("image", "jpg"),
      );
      vars["fields"][Queries.statementPictureFile] = {"upload": multipartFile};
    }

    //add factchecks if not empty
    if (statementFactchecks.facts.isNotEmpty) {
      vars["fields"][Queries.statementFactcheckIDs] = {};
      vars["fields"][Queries.statementFactcheckIDs]["createAndAdd"] =
          statementFactchecks.toMap();
    }
    //add object id if we want to update statements
    if (objectId != null) {
      vars["id"] = objectId;
    }
    return vars;
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
