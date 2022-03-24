import 'package:flutter/material.dart';

import '../provider/queries.dart';
import '../utilities/utilities.dart';

class FactController {
  late TextEditingController factController;
  late TextEditingController yearController;
  late TextEditingController monthController;
  late TextEditingController dayController;
  late TextEditingController linkController;
  late TextEditingController archivedLinkController;
  late TextEditingController authorController;
  late TextEditingController mediaController;
  late TextEditingController languageController;

  FactController.fromMap(Map<String, dynamic> fact) {
    factController = TextEditingController(text: fact["text"]);
    yearController = TextEditingController(text: fact["year"]);
    monthController = TextEditingController(text: fact["month"]);
    dayController = TextEditingController(text: fact["day"]);
    linkController = TextEditingController(text: fact["factLink"]);
    archivedLinkController =
        TextEditingController(text: fact["factArchivedLink"]);
    authorController = TextEditingController(text: fact["author"]);
    mediaController = TextEditingController(text: fact["medium"]);
  }

  FactController(Fact fact) {
    factController = TextEditingController(text: fact.factText);
    factController.addListener(() {
      fact.factText = factController.text;
    });
    // add date conversion functions
    yearController = TextEditingController(text: fact.factYear.toString());
    yearController.addListener(() {
      fact.factYear =
          yearController.text == "" ? 0 : int.parse(yearController.text);
    });
    monthController = TextEditingController(text: fact.factMonth.toString());
    monthController.addListener(() {
      fact.factMonth =
          monthController.text == "" ? 0 : int.parse(monthController.text);
    });
    dayController = TextEditingController(text: fact.factDay.toString());
    dayController.addListener(() {
      fact.factDay =
          dayController.text == "" ? 0 : int.parse(dayController.text);
    });
    linkController = TextEditingController(text: fact.factLink);
    linkController.addListener(() {
      fact.factLink = linkController.text;
    });
    archivedLinkController = TextEditingController(text: fact.factArchivedLink);
    archivedLinkController.addListener(() {
      fact.factArchivedLink = archivedLinkController.text;
    });
    authorController = TextEditingController(text: fact.factAuthor);
    authorController.addListener(() {
      fact.factAuthor = authorController.text;
    });
    mediaController = TextEditingController(text: fact.factMedia);
    mediaController.addListener(() {
      fact.factMedia = mediaController.text;
    });
    languageController = TextEditingController(text: fact.factLanguage);
    languageController.addListener(() {
      fact.factLanguage = languageController.text;
    });
  }

  void dispose() {
    factController.dispose();
    yearController.dispose();
    monthController.dispose();
    dayController.dispose();
    linkController.dispose();
    archivedLinkController.dispose();
    authorController.dispose();
    mediaController.dispose();
  }
}

class FactControllers {
  List<FactController> controllers = [];

  void dispose() {
    for (FactController c in controllers) {
      c.dispose();
    }
  }

  FactControllers(Facts facts) {
    for (Fact fact in facts.facts) {
      controllers.add(FactController(fact));
    }
    //add empty fact controller, if no facts given
    if (facts.facts.isEmpty) {
      controllers.add(FactController(Fact.empty()));
    }
  }
}

class Fact {
  late String factText;
  late int factYear;
  late int factMonth;
  late int factDay;
  late String factLanguage;
  late String factLink;
  String? factArchivedLink;
  late String factAuthor;
  late String factMedia;
  String? objectId;

  Fact(
      this.factText,
      this.factAuthor,
      this.factYear,
      this.factMonth,
      this.factDay,
      this.factLanguage,
      this.factLink,
      this.factMedia,
      this.objectId,
      this.factArchivedLink);

  Fact.fromMap(Map<String, dynamic>? map)
      : factText = map?[Queries.factText],
        factAuthor = map?[Queries.factAuthor],
        factMedia = map?[Queries.factMedia],
        factYear = map?[Queries.factYear],
        factMonth = map?[Queries.factMonth],
        factDay = map?[Queries.factDay],
        factLink = map?[Queries.factLink],
        factLanguage = map?[Queries.factLanguage],
        objectId = map?["objectId"],
        factArchivedLink = map?[Queries.factArchivedLink] ?? "";

  Fact.empty() {
    factText = "";
    factAuthor = "";
    factMedia = "";
    factYear = 0;
    factMonth = 0;
    factDay = 0;
    factLink = "";
    factArchivedLink = "";
    factLanguage = "";
  }
}

class Facts {
  List<Fact> facts = [];
  Facts.fromMap(Map<String, dynamic>? map) {
    for (Map<String, dynamic>? fact in map?["edges"]) {
      facts.add(Fact.fromMap(fact?["node"]));
    }
  }
  Facts() {
    facts.add(Fact.empty());
  }
}
