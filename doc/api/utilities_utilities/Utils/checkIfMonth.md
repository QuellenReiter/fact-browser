


# checkIfMonth method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? checkIfMonth
([TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) textEditingController)





<p>Checks if the Value of a <a href="https://api.flutter.dev/flutter/widgets/TextEditingController-class.html">TextEditingController</a> is a number within
the interval <code>0, 12</code>.</p>



## Implementation

```dart
static String? checkIfMonth(TextEditingController textEditingController) {
  final text = textEditingController.text != ""
      ? int.parse(textEditingController.text)
      : 0;
  if (text > 12) {
    return 'Kein valider Monat.';
  }
  // return null if the text is valid
  return null;
}
```







