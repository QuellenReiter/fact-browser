


# Statement.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



Statement.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>? map)


<p>Construct a <a href="../../models_statement/Statement-class.md">Statement</a> from a <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> containing all fields of the
<a href="../../models_statement/Statement-class.md">Statement</a>.</p>



## Implementation

```dart
Statement.fromMap(Map<String, dynamic>? map)
    : statementText = map?[DbFields.statementText],
      statementAuthor = map?[DbFields.statementAuthor],
      statementCorrectness = map?[DbFields.statementCorrectness],
      statementYear = map?[DbFields.statementYear],
      statementMonth = map?[DbFields.statementMonth],
      statementDay = map?[DbFields.statementDay],
      statementLanguage = map?[DbFields.statementLanguage],
      statementLink = map?[DbFields.statementLink],
      statementCategory = map?[DbFields.statementCategory],
      statementMedia = map?[DbFields.statementMedia],
      statementMediatype = map?[DbFields.statementMediatype],
      samplePictureCopyright = map?[DbFields.statementPictureCopyright],
      statementRectification = map?[DbFields.statementRectification],
      statementPictureURL = map?[DbFields.statementPictureFile]["url"],
      statementFactchecks =
          Facts.fromMap(map?[DbFields.statementFactcheckIDs]),
      objectId = map?["objectId"];
```







