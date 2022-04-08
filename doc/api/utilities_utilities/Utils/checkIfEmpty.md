


# checkIfEmpty method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? checkIfEmpty
([TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) textEditingController)





<p>Checks if the value of a given <a href="https://api.flutter.dev/flutter/widgets/TextEditingController-class.html">TextEditingController</a> is empty. Used for
the errortext on <a href="https://api.flutter.dev/flutter/material/TextField-class.html">TextField</a>.</p>



## Implementation

```dart
static String? checkIfEmpty(TextEditingController textEditingController) {
  final text = textEditingController.text;
  if (text.isEmpty) {
    return 'Kann nicht leer sein';
  }
  // return null if the text is valid
  return null;
}
```







