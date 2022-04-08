


# isComplete method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isComplete
()





<p>Checks if all neccessary fields of the <a href="../../models_statement/Statement-class.md">Statement</a> are filled in.</p>



## Implementation

```dart
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
```







