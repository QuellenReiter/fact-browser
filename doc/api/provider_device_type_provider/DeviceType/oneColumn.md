


# oneColumn method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) oneColumn
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





<p>Returns true if display is so narrow to use a one column layout.</p>



## Implementation

```dart
static bool oneColumn(BuildContext context) {
  return MediaQuery.of(context).size.width < 700;
}
```







