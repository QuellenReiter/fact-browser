import 'package:flutter/material.dart';

/// Contains colors that are needed repeatedly throughout the app.
class DesignColors {
  /// Color for text that sits ontop of Blue backgrounds.
  static Color lightBlue = const Color(0xFFc7ebeb);

  /// Color used for the Appbar and other blue backgrounds.
  static Color backgroundBlue = const Color(0xFF0999bc);

  /// Color used in the logo. Use for strong highlighting.
  static Color pink = const Color(0xFFff3a93);

  /// Color used in the logo.
  static Color yellow = const Color(0xFFf5df5b);

  /// Color used for Fake News, manipulated news. Checked for colorblindness.
  static Color red = const Color(0xFFd55e00);

  /// Color used for Facts and real news. Checked for colorblindness.
  static Color green = const Color(0xFF009e73);

  /// Color for light grey backgrounds.
  static Color lightGrey = const Color(0xFFEEEEEE);
}

/// Contains suggestions to speed up User input and to minimize spelling
/// mistakes.
class Suggestions {
  /// [List] of all some suggestions for [Statement.statementAuthor] and
  /// [Fact.factAuthor].
  static List<String> authorSuggestions = const [
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
  static String statementText = "statement";
  static String statementPicture = "pictureUrl";
  static String statementYear = "year";
  static String statementMonth = "month";
  static String statementDay = "day";
  static String statementMediatype = "mediatype";
  static String statementLanguage = "language";
  static String statementCorrectness = "correctness";
  static String statementLink = "link";
  static String statementRectification = "rectification";
  static String statementCategory = "category";
  static String statementPictureCopyright = "samplePictureCopyright";
  static String statementAuthor = "author";
  static String statementMedia = "media";
  static String statementFactcheckIDs = "factcheckIDs";
  static String statementPictureFile = "PictureFile";

  static String factText = "fact";
  static String factYear = "year";
  static String factMonth = "month";
  static String factDay = "day";
  static String factLanguage = "language";
  static String factLink = "link";
  static String factArchivedLink = "archivedLink";
  static String factAuthor = "author";
  static String factMedia = "media";
}

/// Contains lists of values, that restrict user input for database fields.
class DropdownValues {
  /// [List] of all possible values for [Statement.statementCorrectness].
  static List<String> correctnessValues = [
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
  static List<String> categoryValues = [
    "Politik",
    "Sport",
    "Wirtschaft",
    "Gesellschaft",
    "Wissenschaft",
    "Kultur",
    "Geschichte"
  ];

  /// [List] of all possible values for [Statement.statementMediatype].
  static List<String> mediatypeValues = [
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
