


# MainAppBar constructor




    *[<Null safety>](https://dart.dev/null-safety)*



MainAppBar({[Key](https://api.flutter.dev/flutter/foundation/Key-class.html)? key, required [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title, required [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) onLogin, required [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) loggedIn, [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)? searchController})





## Implementation

```dart
MainAppBar({
  Key? key,
  required this.title,
  required this.onLogin,
  required this.loggedIn,
  this.searchController,
}) : super(key: key);
```







