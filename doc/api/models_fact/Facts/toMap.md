


# toMap method




    *[<Null safety>](https://dart.dev/null-safety)*




[List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic>> toMap
()





<p>Convert the <a href="../../models_fact/Facts-class.md">Facts</a> back to a <code>Map</code> containing all fields.</p>



## Implementation

```dart
List<Map<String, dynamic>> toMap() {
  List<Map<String, dynamic>> ret = [];
  for (var fact in facts) {
    ret.add(fact.toMap());
  }
  return ret;
}
```







