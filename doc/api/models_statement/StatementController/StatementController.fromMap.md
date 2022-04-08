


# StatementController.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



StatementController.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> statement)


<p>Construct a <a href="../../models_statement/StatementController-class.md">StatementController</a> given a <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> containing all fields of a
<a href="../../models_statement/Statement-class.md">Statement</a> and its <a href="../../models_fact/Facts-class.md">Facts</a>.</p>



## Implementation

```dart
StatementController.fromMap(Map<String, dynamic> statement) {
  textController =
      TextEditingController(text: statement[DbFields.statementText]);
  yearController =
      TextEditingController(text: statement[DbFields.statementYear]);
  monthController =
      TextEditingController(text: statement[DbFields.statementYear]);
  dayController =
      TextEditingController(text: statement[DbFields.statementYear]);
  mediaTypeController =
      TextEditingController(text: statement[DbFields.statementMediatype]);
  correctnessController =
      TextEditingController(text: statement[DbFields.statementCorrectness]);
  categoryController =
      TextEditingController(text: statement[DbFields.statementCategory]);
  samplePictureCopyrightController = TextEditingController(
      text: statement[DbFields.statementPictureCopyright]);
  linkController =
      TextEditingController(text: statement[DbFields.statementLink]);
  authorController =
      TextEditingController(text: statement[DbFields.statementAuthor]);
  mediaController =
      TextEditingController(text: statement[DbFields.statementMedia]);
}
```







