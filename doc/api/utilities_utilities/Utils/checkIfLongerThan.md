


# checkIfLongerThan method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? checkIfLongerThan
([TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) textEditingController, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) minLength)





<p>Checks if the Value of a <a href="https://api.flutter.dev/flutter/widgets/TextEditingController-class.html">TextEditingController</a> is longer than
<code>minLength</code>.</p>



## Implementation

```dart
static String? checkIfLongerThan(
    TextEditingController textEditingController, int minLength) {
  final text = textEditingController.text;
  if (text.length < minLength) {
    return 'Mindestens ${minLength.toString()} Zeichen';
  }
  // return null if the text is valid
  return null;
}
```







