


# deleteFact method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) deleteFact
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) factId)





<p>Returns the graphQL mutation to delete a <a href="../../models_fact/Fact-class.md">Fact</a> by <a href="../../models_fact/Fact/objectId.md">Fact.objectId</a>.</p>



## Implementation

```dart
static String deleteFact(String factId) {
  // how to ensure that facts are not duplicated but changes
  // are still updated..??

  String ret = '''
mutation deleteAFact{
deleteFactcheck(
  input:{
    id: "$factId"
  }
  ){
  factcheck{
    fact
  }
}
}
''';
  return ret;
}
```







