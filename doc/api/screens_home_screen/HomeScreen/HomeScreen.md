


# HomeScreen constructor




    *[<Null safety>](https://dart.dev/null-safety)*


const
HomeScreen({[Key](https://api.flutter.dev/flutter/foundation/Key-class.html)? key, required [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title, required [ValueChanged](https://api.flutter.dev/flutter/foundation/ValueChanged.html)&lt;[Statement](../../models_statement/Statement-class.md)> onSelectStatement, required [ValueChanged](https://api.flutter.dev/flutter/foundation/ValueChanged.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> onQueryChanged, required [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? query, required [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) onLogin, required [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isLoggedIn, required [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) createStatement})





## Implementation

```dart
const HomeScreen(
    {Key? key,
    required this.title,
    required this.onSelectStatement,
    required this.onQueryChanged,
    required this.query,
    required this.onLogin,
    required this.isLoggedIn,
    required this.createStatement})
    : super(key: key);
```







