


# isHandset method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isHandset
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





<p>Checks if device is a mobile and not wider than 700px.</p>



## Implementation

```dart
static bool isHandset(BuildContext context) {
  return (Platform.isAndroid || Platform.isIOS) &&
      MediaQuery.of(context).size.width < 700;
}
```







