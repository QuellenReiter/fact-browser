


# login method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) login
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) username, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) password)





<p>Returns the graphQL mutation to login.</p>



## Implementation

```dart
static String login(String username, String password) {
  String ret = '''
mutation LogIn{
logIn(input: {
  username: "$username"
  password: "$password"
}){
  viewer{
    sessionToken
  }
}
}
''';
  return ret;
}
```







