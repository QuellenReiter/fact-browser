


# checkIfEmptyOrEqualTo method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? checkIfEmptyOrEqualTo
([TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) textEditingController, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) compareString)





<p>Checks if the Value of a <a href="https://api.flutter.dev/flutter/widgets/TextEditingController-class.html">TextEditingController</a> is empy or equal to a
given string <code>compareString</code>.</p>



## Implementation

```dart
static String? checkIfEmptyOrEqualTo(
    TextEditingController textEditingController, String compareString) {
  final text = textEditingController.text;
  if (text == compareString) {
    return 'Text ist unverändert';
  }
  // return null if the text is valid
  return null;
}
```







