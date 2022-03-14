import 'package:statementmanager/models/statement.dart';

import '../models/fact.dart';

class Queries {
  static String statementText = "statement";
  static String statementPicture = "picture";
  static String statementDate = "date";
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

  static String factText = "fact";
  static String factDate = "date";
  static String factLanguage = "language";
  static String factLink = "link";
  static String factAuthor = "author";
  static String factMedia = "media";

  static List<String> correctnessValues = [
    "richtig",
    "unbelegt", 
    "falscher Kontext", 
    "manipuliert", 
    "irreführend", 
    "frei erfunden", 
    "Fehlinformation"];

  static List<String> categoryValues = [
    "Politik",
    "Sport", 
    "Wirtschaft", 
    "Gesellschaft", 
    "Wissenschaft", 
    "Kultur", 
    "Geschichte"];

  static List<String> mediatypeValues = [
    "Online-Artikel",
    "Print-Artikel", 
    "Interview", 
    "Social Media Post", 
    "Werbung", 
    "Foto", 
    "Video",
    "TV-Beitrag"];


  // static String[4] categories = [];

  //
  static String searchStatements(String query) {
    String ret = '''
  query searchStatementsByWord{
  statements(
    where:{
      OR:[
        { $statementText: { matchesRegex: "$query", options: "i"} }
        { $statementFactcheckIDs : { have:{ $factText:{ matchesRegex: "$query", options: "i" } } } }
      ]
  }){
    edges{
      node{
        $statementText
        $statementPicture{url}
        $statementDate
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
                $factText
                $factAuthor
                $factDate
                $factLanguage
                $factMedia
                $factLink
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

  static String createStatement(Statement statement) {
    String factString = "[";
    for (Fact fact in statement.statementFactchecks.facts){
        factString += '''
            {
              $factText: "${fact.factText}",
              $factAuthor:"${fact.factAuthor}",
              $factDate:"${fact.factDate}",
              $factLanguage:"${fact.factLanguage}",
              $factMedia:"${fact.factMedia}",
              $factLink:"${fact.factLink}"
              },
''';
    }
  factString += "]";


    String ret = '''
  mutation createAStatement{
  createStatement(
    input:{
      fields:{
        $statementText: "${statement.statementText}",
        $statementPicture: "${statement.statementPictureURL}",
        $statementDate: "${statement.statementDate}",
        $statementCorrectness: "${statement.statementCorrectness}",
        $statementMedia: "${statement.statementMedia}",
        $statementLanguage: "${statement.statementLanguage}",
        $statementCategory: "${statement.statementCategory}",
        $statementMediatype: "${statement.statementMediatype}",
        $statementAuthor: "${statement.statementAuthor}",
        $statementLink: "${statement.statementLink}",
        $statementRectification: "${statement.statementRectification}",
        $statementPictureCopyright: "${statement.samplePictureCopyright}",
        $statementFactcheckIDs{
          createAndAdd:
              $factString
        }
      }
    }
    ){
    edges{
      node{
        $statementText,
        $statementPicture,
        $statementDate,
        $statementCorrectness,
        $statementMedia,
        $statementLanguage,
        $statementCategory,
        $statementMediatype,
        $statementAuthor,
        $statementLink,
        $statementRectification,
        $statementPictureCopyright
        $statementFactcheckIDs{
            edges{
              node{
                $factText,
                $factAuthor,
                $factDate,
                $factLanguage,
                $factMedia,
                $factLink
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
}
