


# dispose method




    *[<Null safety>](https://dart.dev/null-safety)*




void dispose
()





<p>Dispose all <a href="https://api.flutter.dev/flutter/widgets/TextEditingController-class.html">TextEditingController</a> at once.</p>



## Implementation

```dart
void dispose() {
  textController.dispose();
  yearController.dispose();
  monthController.dispose();
  dayController.dispose();
  mediaTypeController.dispose();
  correctnessController.dispose();
  categoryController.dispose();
  samplePictureCopyrightController.dispose();
  linkController.dispose();
  authorController.dispose();
  mediaController.dispose();
}
```







