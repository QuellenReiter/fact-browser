


# dispose method




    *[<Null safety>](https://dart.dev/null-safety)*




void dispose
()





<p>Dispose all <a href="https://api.flutter.dev/flutter/widgets/TextEditingController-class.html">TextEditingController</a> at once.</p>



## Implementation

```dart
void dispose() {
  factController.dispose();
  yearController.dispose();
  monthController.dispose();
  dayController.dispose();
  linkController.dispose();
  archivedLinkController.dispose();
  authorController.dispose();
  mediaController.dispose();
}
```







