


# TextFieldContainer constructor




    *[<Null safety>](https://dart.dev/null-safety)*


const
TextFieldContainer({[Key](https://api.flutter.dev/flutter/foundation/Key-class.html)? key, required [TextEditingController](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) textController, required [String](https://api.flutter.dev/flutter/dart-core/String-class.html) label, required [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) errorCallback, [TextInputFormatter](https://api.flutter.dev/flutter/services/TextInputFormatter-class.html)? inputFormatter, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)>? autoCompleteList, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) color = Colors.transparent})





## Implementation

```dart
const TextFieldContainer(
    {Key? key,
    required this.textController,
    required this.label,
    required this.errorCallback,
    this.inputFormatter,
    this.autoCompleteList,
    this.color = Colors.transparent})
    : super(key: key);
```







