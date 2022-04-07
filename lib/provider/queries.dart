import 'package:statementmanager/models/statement.dart';

import '../models/fact.dart';

/// Class containg various utilities for the database connection.
class Queries {
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

  /// Returns the graphQL query to search for [Statements].
  static String searchStatements(String query) {
    String ret = '''
  query searchStatementsByWord{
  statements(
    where:{
      OR:[
        { $statementText: { matchesRegex: "$query", options: "i"} }
        { $statementMedia: { matchesRegex: "$query", options: "i"} }
        { $statementFactcheckIDs : { have:{ $factText:{ matchesRegex: "$query", options: "i" } } } }
        { $statementFactcheckIDs : { have:{ $factMedia:{ matchesRegex: "$query", options: "i" } } } }
      ]
  }){
    edges{
      node{
        objectId
        $statementText
        $statementPictureFile{url}
        $statementYear
        $statementMonth
        $statementDay
        $statementCorrectness
        $statementMedia
        $statementLanguage
        $statementCategory
        $statementMediatype
        $statementAuthor
        $statementLink
        $statementRectification
        $statementPictureCopyright
        $statementFactcheckIDs{
            edges{
              node{
                objectId
                $factText
                $factAuthor
                $statementYear
                $statementMonth
                $statementDay
                $factLanguage
                $factMedia
                $factLink
                $factArchivedLink
              }
            }
        }
      }
    }
  }
}
  ''';
    return ret;
  }

  /// Returns the graphQL mutation to create a [Statement].
  static String createStatement() {
    String ret = '''
  mutation createAStatement(\$input: CreateStatementInput!){
  createStatement(
       input: \$input
    ){
  statement{
    objectId
    $statementText
    $statementPictureFile{url}
    $statementYear
    $statementMonth
    $statementDay
    $statementCorrectness
    $statementMedia
    $statementLanguage
    $statementCategory
    $statementMediatype
    $statementAuthor
    $statementLink
    $statementRectification
    $statementPictureCopyright
    $statementFactcheckIDs{
        edges{
          node{
            objectId
            $factText
            $factAuthor
            $factYear
            $factMonth
            $factDay
            $factLanguage
            $factMedia
            $factLink
            $factArchivedLink
          }
        }
      }
    }
  }
}
  ''';
    return ret;
  }

  /// Returns the graphQL mutation to update a [Statement].
  static String updateStatement() {
    String ret = '''
  mutation updateAStatement(\$input: UpdateStatementInput!){
  updateStatement(
       input: \$input
    ){
  statement{
    objectId
    $statementText
    $statementPictureFile{url}
    $statementYear
    $statementMonth
    $statementDay
    $statementCorrectness
    $statementMedia
    $statementLanguage
    $statementCategory
    $statementMediatype
    $statementAuthor
    $statementLink
    $statementRectification
    $statementPictureCopyright
    $statementFactcheckIDs{
        edges{
          node{
            objectId
              $factText
              $factAuthor
              $factYear
              $factMonth
              $factDay
              $factLanguage
              $factMedia
              $factLink
              $factArchivedLink
          }
        }
      }
    }
  }
}
  ''';
    return ret;
  }

  /// Returns the graphQL mutation to delete a [Fact] by [Fact.objectId].
  static String deleteFact(String factId) {
    // how to ensure that facts are not duplicated but changes
    // are still updated..??

    String ret = '''
  mutation deleteAFact{
  deleteFactcheck(
    input:{
      id: "$factId"
    }
    ){
    factcheck{
      fact
    }
  }
}
  ''';
    return ret;
  }

  /// Returns the graphQL mutation to login.
  static String login(String username, String password) {
    String ret = '''
mutation LogIn{
  logIn(input: {
    username: "$username"
    password: "$password"
  }){
    viewer{
      sessionToken
    }
  }
}
''';
    return ret;
  }

  /// Returns the graphQL query to check the current user.
  static String getCurrentUser() {
    String ret = '''
query GetCurrentUser{
  viewer{
    sessionToken
  }
}
''';
    return ret;
  }

  /// Returns the graphQL query to get a [Statement] by [Statement.objectId].
  static String getStatement(String? statementID) {
    String ret = '''
query getStatement{
  statement(
    	id: "$statementID"
  ){
    objectId
    $statementText
    $statementPictureFile{url}
    $statementYear
    $statementMonth
    $statementDay
    $statementCorrectness
    $statementMedia
    $statementLanguage
    $statementCategory
    $statementMediatype
    $statementAuthor
    $statementLink
    $statementRectification
    $statementPictureCopyright
    $statementFactcheckIDs{
      edges{
        node{
          objectId
            $factText
            $factAuthor
            $factYear
            $factMonth
            $factDay
            $factLanguage
            $factMedia
            $factLink
            $factArchivedLink
        }
      }
    }
  }
}
''';
    return ret;
  }
}
