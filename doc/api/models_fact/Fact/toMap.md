


# toMap method




    *[<Null safety>](https://dart.dev/null-safety)*




[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> toMap
()





<p>Convert a <a href="../../models_fact/Fact-class.md">Fact</a> back to its <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> representation.</p>



## Implementation

```dart
Map<String, dynamic> toMap() {
  final Map<String, dynamic> vars = {
    DbFields.factText: factText,
    DbFields.factLanguage: factLanguage,
    DbFields.factYear: factYear,
    DbFields.factMonth: factMonth,
    DbFields.factDay: factDay,
    DbFields.factLink: factLink,
    DbFields.factAuthor: factAuthor,
    DbFields.factArchivedLink: factArchivedLink,
    DbFields.factMedia: factMedia
  };
  return vars;
}
```







