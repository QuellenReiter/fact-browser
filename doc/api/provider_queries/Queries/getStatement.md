


# getStatement method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) getStatement
([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? statementID)





<p>Returns the graphQL query to get a <a href="../../models_statement/Statement-class.md">Statement</a> by <a href="../../models_statement/Statement/objectId.md">Statement.objectId</a>.</p>



## Implementation

```dart
static String getStatement(String? statementID) {
  String ret = '''
query getStatement{
statement(
  	id: "$statementID"
){
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
          ${DbFields.factYear}
          ${DbFields.factMonth}
          ${DbFields.factDay}
          ${DbFields.factLanguage}
          ${DbFields.factMedia}
          ${DbFields.factLink}
          ${DbFields.factArchivedLink}
      }
    }
  }
}
}
''';
  return ret;
}
```







