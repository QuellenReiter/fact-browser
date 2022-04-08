


# searchStatements method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) searchStatements
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) query)





<p>Returns the graphQL query to search for <a href="../../models_statement/Statements-class.md">Statements</a>.</p>



## Implementation

```dart
static String searchStatements(String query) {
  String ret = '''
query searchStatementsByWord{
statements(
  where:{
    OR:[
      { ${DbFields.statementText}: { matchesRegex: "$query", options: "i"} }
      { ${DbFields.statementMedia}: { matchesRegex: "$query", options: "i"} }
      { ${DbFields.statementFactcheckIDs} : { have:{ ${DbFields.factText}:{ matchesRegex: "$query", options: "i" } } } }
      { ${DbFields.statementFactcheckIDs} : { have:{ ${DbFields.factMedia}:{ matchesRegex: "$query", options: "i" } } } }
    ]
}){
  edges{
    node{
      objectId
      ${DbFields.statementText}
      ${DbFields.statementPictureFile}{url}
      ${DbFields.statementYear}
      ${DbFields.statementMonth}
      ${DbFields.statementDay}
      ${DbFields.statementCorrectness}
      ${DbFields.statementMedia}
      ${DbFields.statementLanguage}
      ${DbFields.statementCategory}
      ${DbFields.statementMediatype}
      ${DbFields.statementAuthor}
      ${DbFields.statementLink}
      ${DbFields.statementRectification}
      ${DbFields.statementPictureCopyright}
      ${DbFields.statementFactcheckIDs}{
          edges{
            node{
              objectId
              ${DbFields.factText}
              ${DbFields.factAuthor}
              ${DbFields.statementYear}
              ${DbFields.statementMonth}
              ${DbFields.statementDay}
              ${DbFields.factLanguage}
              ${DbFields.factMedia}
              ${DbFields.factLink}
              ${DbFields.factArchivedLink}
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
```







