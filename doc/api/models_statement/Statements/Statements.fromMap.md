


# Statements.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



Statements.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>? map)


<p>Convert the <a href="../../models_statement/Statements-class.md">Statements</a> back to a <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> containing all fields.</p>



## Implementation

```dart
Statements.fromMap(Map<String, dynamic>? map) {
  for (Map<String, dynamic>? statement in map?["statements"]["edges"]) {
    statements.add(Statement.fromMap(statement?["node"]));
  }
}
```







