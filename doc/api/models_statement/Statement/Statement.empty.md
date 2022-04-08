


# Statement.empty constructor




    *[<Null safety>](https://dart.dev/null-safety)*



Statement.empty()


<p>Construct an empty <a href="../../models_statement/Statement-class.md">Statement</a>.</p>



## Implementation

```dart
Statement.empty() {
  statementText = "";
  statementAuthor = "";
  statementCategory = DropdownValues.categoryValues.first;
  statementCorrectness = DropdownValues.correctnessValues.first;
  statementYear = 0;
  statementMonth = 0;
  statementDay = 0;
  statementFactchecks = Facts();
  statementLanguage = "";
  statementLink = "";
  statementMedia = "";
  statementMediatype = DropdownValues.mediatypeValues.first;
  statementPictureURL = "emptyButNotEmpty";
  samplePictureCopyright = "";
  statementRectification = false;
}
```







