


# FactController.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



FactController.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> fact)


<p>Construct a <a href="../../models_fact/FactController-class.md">FactController</a> given a <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> containing all fields of a
<a href="../../models_fact/Fact-class.md">Fact</a>.</p>



## Implementation

```dart
FactController.fromMap(Map<String, dynamic> fact) {
  factController = TextEditingController(text: fact["text"]);
  yearController = TextEditingController(text: fact["year"]);
  monthController = TextEditingController(text: fact["month"]);
  dayController = TextEditingController(text: fact["day"]);
  linkController = TextEditingController(text: fact["factLink"]);
  archivedLinkController =
      TextEditingController(text: fact["factArchivedLink"]);
  authorController = TextEditingController(text: fact["author"]);
  mediaController = TextEditingController(text: fact["medium"]);
}
```







