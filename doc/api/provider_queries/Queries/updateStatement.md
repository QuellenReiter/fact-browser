


# updateStatement method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) updateStatement
()





<p>Returns the graphQL mutation to update a <a href="../../models_statement/Statement-class.md">Statement</a>.</p>



## Implementation

```dart
static String updateStatement() {
  String ret = '''
mutation updateAStatement(\$input: UpdateStatementInput!){
updateStatement(
     input: \$input
  ){
statement{
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
}
''';
  return ret;
}
```







