


# height method




    *[<Null safety>](https://dart.dev/null-safety)*




[double](https://api.flutter.dev/flutter/dart-core/double-class.html) height
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)





<p>Returns the height of the browser window.</p>



## Implementation

```dart
static double height(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
```







