


# Fact.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



Fact.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>? map)


<p>Construct a <a href="../../models_fact/Fact-class.md">Fact</a> from a <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> containing all fields of the <a href="../../models_fact/Fact-class.md">Fact</a>.</p>



## Implementation

```dart
Fact.fromMap(Map<String, dynamic>? map)
    : factText = map?[DbFields.factText],
      factAuthor = map?[DbFields.factAuthor],
      factMedia = map?[DbFields.factMedia],
      factYear = map?[DbFields.factYear],
      factMonth = map?[DbFields.factMonth],
      factDay = map?[DbFields.factDay],
      factLink = map?[DbFields.factLink],
      factLanguage = map?[DbFields.factLanguage],
      objectId = map?["objectId"],
      factArchivedLink = map?[DbFields.factArchivedLink] ?? "";
```







