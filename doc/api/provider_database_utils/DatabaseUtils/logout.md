


# logout method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> logout
()





<p>Logsout a user by deleting the session token.</p>



## Implementation

```dart
Future<void> logout() async {
  const safeStorage = FlutterSecureStorage();
  await safeStorage.delete(key: "token");
}
```







