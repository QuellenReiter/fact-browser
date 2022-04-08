


# compressImage method




    *[<Null safety>](https://dart.dev/null-safety)*




void compressImage
([Uint8List](https://api.flutter.dev/flutter/dart-typed_data/Uint8List-class.html) pic, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) callback)





<p>compress an Image <code>pic</code> and pass it to a <code>callback</code>.</p>



## Implementation

```dart
static void compressImage(Uint8List pic, Function callback) async {
  img.Image tempFile = img.decodeImage(List.from(pic))!;
  tempFile = img.copyResize(
    tempFile,
    width: tempFile.height > tempFile.width ? -1 : 800,
    height: tempFile.height > tempFile.width ? 800 : -1,
  );
  // convert back to bytes
  callback(img.encodeJpg(tempFile, quality: 50));
}
```







