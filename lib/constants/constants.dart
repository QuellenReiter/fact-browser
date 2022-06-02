import 'package:flutter/material.dart';

/// Contains colors that are needed repeatedly throughout the app.
class DesignColors {
  /// Color for text that sits ontop of Blue backgrounds.
  static const Color lightBlue = const Color(0xFFc7ebeb);

  /// Color used for the Appbar and other blue backgrounds.
  static const Color backgroundBlue = const Color(0xFF0999bc);

  /// Color used in the logo. Use for strong highlighting.
  static const Color pink = const Color(0xFFff3a93);

  /// Color used in the logo.
  static const Color yellow = const Color(0xFFf5df5b);

  /// Color used for Fake News, manipulated news. Checked for colorblindness.
  static const Color red = const Color(0xFFd55e00);

  /// Color used for Facts and real news. Checked for colorblindness.
  static const Color green = const Color(0xFF009e73);

  /// Color for light grey backgrounds.
  static const Color lightGrey = const Color(0xFFEEEEEE);

  /// Color for light grey backgrounds.
  static const Color black = const Color.fromARGB(255, 23, 23, 23);
}

/// Contains suggestions to speed up User input and to minimize spelling
/// mistakes.
class Suggestions {
  /// [List] of all some suggestions for [Statement.statementAuthor] and
  /// [Fact.factAuthor].
  static const List<String> authorSuggestions = [
    "unbekannt",
    "geteilt von mehreren User:innen",
    "Donald Trump",
  ];

  /// [List] of all some suggestions for [Statement.statementMedia] and
  /// [Fact.factMedia].
  static List<String> mediaSuggestions = const [
    "Twitter",
    "Facebook",
    "Correctiv",
    "Focus",
    "Tagesschau",
    "unbekannt",
    "Spiegel",
    "Deutsche Presse-Agentur (dpa)",
    "Zeit",
    "Süddeutsche Zeitung (SZ)",
    "Reuters",
    "Agence France-Presse (AFP)",
    "Mimikama",
    "Deutsche Welle (DW)",
    "Snopes",
    "TikTok",
    "Instagram"
  ];

  /// [List] of all some suggestions for [Statement.statementLanguage] and
  /// [Fact.factLanguage].
  static List<String> languageSuggestions = const [
    "deutsch",
    "englisch",
    "türkisch",
    "spanisch",
    "russisch"
  ];
}

/// Contains the names of DatabaseFields that are needed for querying.
class DbFields {
  static const String statementText = "statement";
  static const String statementPicture = "pictureUrl";
  static const String statementYear = "year";
  static const String statementMonth = "month";
  static const String statementDay = "day";
  static const String statementMediatype = "mediatype";
  static const String statementLanguage = "language";
  static const String statementCorrectness = "correctness";
  static const String statementLink = "link";
  static const String statementRectification = "rectification";
  static const String statementCategory = "category";
  static const String statementPictureCopyright = "samplePictureCopyright";
  static const String statementAuthor = "author";
  static const String statementMedia = "media";
  static const String statementFactcheckIDs = "factcheckIDs";
  static const String statementPictureFile = "PictureFile";

  static const String factText = "fact";
  static const String factYear = "year";
  static const String factMonth = "month";
  static const String factDay = "day";
  static const String factLanguage = "language";
  static const String factLink = "link";
  static const String factArchivedLink = "archivedLink";
  static const String factAuthor = "author";
  static const String factMedia = "media";
}

/// Contains lists of values, that restrict user input for database fields.
class DropdownValues {
  /// [List] of all possible values for [Statement.statementCorrectness].
  static const List<String> correctnessValues = [
    "richtig",
    "unbelegt",
    "falscher Kontext",
    "manipuliert",
    "irreführend",
    "frei erfunden",
    "Fehlinformation",
    "Satire",
    "falsch"
  ];

  /// [List] of all possible values for [Statement.statementCategory].
  static const List<String> categoryValues = [
    "Politik",
    "Sport",
    "Wirtschaft",
    "Gesellschaft",
    "Wissenschaft",
    "Kultur",
    "Geschichte"
  ];

  /// [List] of all possible values for [Statement.statementMediatype].
  static const List<String> mediatypeValues = [
    "Online-Artikel",
    "Print-Artikel",
    "Interview",
    "Social Media Post",
    "Werbung",
    "Foto",
    "Video",
    "TV-Beitrag",
    "Mythos"
  ];
}
