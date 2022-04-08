


# Facts.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



Facts.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>? map)


<p>Construct <a href="../../models_fact/Facts-class.md">Facts</a> from a <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> containing all fields for a number of
<a href="../../models_fact/Fact-class.md">Fact</a>.</p>



## Implementation

```dart
Facts.fromMap(Map<String, dynamic>? map) {
  for (Map<String, dynamic>? fact in map?["edges"]) {
    facts.add(Fact.fromMap(fact?["node"]));
  }
}
```







