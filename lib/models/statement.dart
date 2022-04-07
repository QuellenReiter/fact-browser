import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/provider/queries.dart';

/// This holds all [TextEditingController] to create and edit a [Statement].
class StatementController {
  /// [TextEditingController] for [Statement.statementText].
  late TextEditingController textController;

  /// [TextEditingController] for [Statement.statementYear].
  late TextEditingController yearController;

  /// [TextEditingController] for [Statement.statementMonth].
  late TextEditingController monthController;

  /// [TextEditingController] for [Statement.statementDay].
  late TextEditingController dayController;

  /// [TextEditingController] for [Statement.statementMedia].
  late TextEditingController mediaTypeController;

  /// [TextEditingController] for [Statement.statementCorrectness].
  late TextEditingController correctnessController;

  /// [TextEditingController] for [Statement.statementCategory].
  late TextEditingController categoryController;

  /// [TextEditingController] for [Statement.samplePictureCopyright].
  late TextEditingController samplePictureCopyrightController;

  /// [TextEditingController] for [Statement.statementLink].
  late TextEditingController linkController;

  /// [TextEditingController] for [Statement.statementAuthor].
  late TextEditingController authorController;

  /// [TextEditingController] for [Statement.statementMedia].
  late TextEditingController mediaController;

  /// [TextEditingController] for [Statement.statementLanguage].
  late TextEditingController languageController;

  /// Construct a [StatementController] given a [Map] containing all fields of a
  /// [Statement] and its [Facts].
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

  /// Construct a [StatementController] given a [Statement].
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

  /// Dispose all [TextEditingController] at once.
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

/// A class to hold information of a Statement.
class Statement {
  /// The claim of the statement.
  late String statementText;

  /// The URL to a picture describing the statement.
  late String statementPictureURL;

  /// The Year of the statement publication.
  late int statementYear;

  /// The Month of the statement publication.
  late int statementMonth;

  /// The Day of the statement publication.
  late int statementDay;

  /// The Mediatype of the statement.
  late String statementMediatype;

  /// The Language of the statement.
  late String statementLanguage;

  /// The correctness of the statement. One of [Queries.correctnessValues].
  late String statementCorrectness;

  /// The Link to the statement, mostly an archived link.
  late String statementLink;

  /// Stores if the statement was corrected.
  late bool statementRectification;

  /// The Category of the statement. One of [Queries.categoryValues].
  late String statementCategory;

  /// The copyright text of the [Statement.statementPictureURL].
  late String samplePictureCopyright;

  /// The Author of the statement.
  late String statementAuthor;

  /// The Media publishing the statement.
  late String statementMedia;

  /// The [Facts] of the statement.
  late Facts statementFactchecks;

  /// An image to be uploaded stored as bytes.
  Uint8List? uploadImage;

  /// The ID of the statement in the database.
  String? objectId;

  /// Default constructor.
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

  /// Construct a [Statement] from a [Map] containing all fields of the
  /// [Statement].
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

  /// Construct an empty [Statement].
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

  /// Checks if all neccessary fields of the [Statement] are filled in.
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
    //check all facts
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

  /// Return the [Statement.statementDay], [Statement.statementMonth] and
  /// [Statement.statementYear] as [String] like so dd/mm/yyyy.
  ///
  /// If no [Statement.statementDay] and/or no [Statement.statementMonth] is
  /// given, the returned [String] ommits these fields like so mm/yyyy or yyyy.
  String dateAsString() {
    String ret = "";
    if (statementDay != 0) {
      ret += statementDay.toString().padLeft(2, "0") + '/';
    }
    if (statementMonth != 0) {
      ret += statementMonth.toString().padLeft(2, "0") + '/';
    }
    if (statementYear != 0) {
      ret += statementYear.toString();
    }
    return ret;
  }

  /// Convert a [Statement] back to its [Map] representation.
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

/// A class containing a [List] of [Statement].
class Statements {
  /// The [List] of [Statement].
  List<Statement> statements = [];

  /// Convert the [Statements] back to a [Map] containing all fields.
  Statements.fromMap(Map<String, dynamic>? map) {
    for (Map<String, dynamic>? statement in map?["statements"]["edges"]) {
      statements.add(Statement.fromMap(statement?["node"]));
    }
  }
}
