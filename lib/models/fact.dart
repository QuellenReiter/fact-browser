import 'package:flutter/material.dart';

import '../provider/queries.dart';
import '../utilities/utilities.dart';

class FactController {
  late TextEditingController factController;
  late TextEditingController dateController;
  late TextEditingController linkController;
  late TextEditingController authorController;
  late TextEditingController mediaController;
  late TextEditingController languageController;

  FactController.fromMap(Map<String, dynamic> statement) {
    factController = TextEditingController(text: statement["text"]);
    dateController = TextEditingController(text: statement["date"]);
    linkController = TextEditingController(text: statement["statementLink"]);
    authorController = TextEditingController(text: statement["author"]);
    mediaController = TextEditingController(text: statement["medium"]);
  }

  FactController(Fact fact) {
    factController = TextEditingController(text: fact.factText);
    factController.addListener(() {
      fact.factText = factController.text;
    });
    // add date conversion functions
    dateController = TextEditingController(text: fact.factDate);
    dateController.addListener(() {
      fact.factDate = dateController.text;
    });
    linkController = TextEditingController(text: fact.factLink);
    linkController.addListener(() {
      fact.factLink = linkController.text;
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
    dateController.dispose();
    linkController.dispose();
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
  late String factDate;
  late String factLanguage;
  late String factLink;
  late String factAuthor;
  late String factMedia;
  String? objectId;

  Fact(this.factText, this.factAuthor, this.factDate, this.factLanguage,
      this.factLink, this.factMedia, this.objectId);

  Fact.fromMap(Map<String, dynamic>? map)
      : factText = map?[Queries.factText],
        factAuthor = map?[Queries.factAuthor],
        factMedia = map?[Queries.factMedia],
        factDate = Utils.formatDate(map?[Queries.factDate]),
        factLink = map?[Queries.factLink],
        factLanguage = map?[Queries.factLanguage],
        objectId = map?["objectId"];

  Fact.empty() {
    factText = "";
    factAuthor = "";
    factMedia = "";
    factDate = "";
    factLink = "";
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
