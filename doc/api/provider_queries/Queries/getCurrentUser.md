


# getCurrentUser method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) getCurrentUser
()





<p>Returns the graphQL query to check the current user.</p>



## Implementation

```dart
static String getCurrentUser() {
  String ret = '''
query GetCurrentUser{
viewer{
  sessionToken
}
}
''';
  return ret;
}
```







