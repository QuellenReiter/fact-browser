


# StatementController constructor




    *[<Null safety>](https://dart.dev/null-safety)*



StatementController([Statement](../../models_statement/Statement-class.md) statement)


<p>Construct a <a href="../../models_statement/StatementController-class.md">StatementController</a> given a <a href="../../models_statement/Statement-class.md">Statement</a>.</p>



## Implementation

```dart
StatementController(Statement statement) {
  textController = TextEditingController(text: statement.statementText);
  textController.addListener(() {
    statement.statementText = textController.text;
  });
  yearController =
      TextEditingController(text: statement.statementYear.toString());
  yearController.addListener(() {
    statement.statementYear =
        yearController.text == "" ? 0 : int.parse(yearController.text);
  });
  monthController =
      TextEditingController(text: statement.statementMonth.toString());
  monthController.addListener(() {
    statement.statementMonth =
        monthController.text == "" ? 0 : int.parse(monthController.text);
  });
  dayController =
      TextEditingController(text: statement.statementDay.toString());
  dayController.addListener(() {
    statement.statementDay =
        dayController.text == "" ? 0 : int.parse(dayController.text);
  });
  mediaTypeController =
      TextEditingController(text: statement.statementMediatype);
  mediaTypeController.addListener(() {
    statement.statementMediatype = mediaTypeController.text;
  });
  correctnessController =
      TextEditingController(text: statement.statementCorrectness);
  correctnessController.addListener(() {
    statement.statementCorrectness = correctnessController.text;
  });
  categoryController =
      TextEditingController(text: statement.statementCategory);
  categoryController.addListener(() {
    statement.statementCategory = categoryController.text;
  });
  linkController = TextEditingController(text: statement.statementLink);
  linkController.addListener(() {
    statement.statementLink = linkController.text;
  });
  samplePictureCopyrightController =
      TextEditingController(text: statement.samplePictureCopyright);
  samplePictureCopyrightController.addListener(() {
    statement.samplePictureCopyright = samplePictureCopyrightController.text;
  });
  authorController = TextEditingController(text: statement.statementAuthor);
  authorController.addListener(() {
    statement.statementAuthor = authorController.text;
  });
  mediaController = TextEditingController(text: statement.statementMedia);
  mediaController.addListener(() {
    statement.statementMedia = mediaController.text;
  });
  languageController =
      TextEditingController(text: statement.statementLanguage);
  languageController.addListener(() {
    statement.statementLanguage = languageController.text;
  });
}
```







