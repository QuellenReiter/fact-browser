


# checkIfYear method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? checkIfYear
([TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) textEditingController)





<p>Checks if the Value of a <a href="https://api.flutter.dev/flutter/widgets/TextEditingController-class.html">TextEditingController</a> is a number within
smaller than the current year.</p>



## Implementation

```dart
static String? checkIfYear(TextEditingController textEditingController) {
  final text = textEditingController.text != ""
      ? int.parse(textEditingController.text)
      : 0;
  if (text > DateTime.now().year) {
    return 'Keine Zeitreise bitte.';
  }
  // return null if the text is valid
  return null;
}
```







