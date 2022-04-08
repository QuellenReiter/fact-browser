


# toMap method




    *[<Null safety>](https://dart.dev/null-safety)*




[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> toMap
()





<p>Convert a <a href="../../models_statement/Statement-class.md">Statement</a> back to its <a href="https://api.flutter.dev/flutter/dart-core/Map-class.html">Map</a> representation.</p>



## Implementation

```dart
Map<String, dynamic> toMap() {
  Map<String, dynamic> vars = {
    "fields": {
      DbFields.statementText: statementText,
      DbFields.statementPicture: statementPictureURL,
      DbFields.statementYear: statementYear,
      DbFields.statementMonth: statementMonth,
      DbFields.statementDay: statementDay,
      DbFields.statementCorrectness: statementCorrectness,
      DbFields.statementMedia: statementMedia,
      DbFields.statementLanguage: statementLanguage,
      DbFields.statementCategory: statementCategory,
      DbFields.statementMediatype: statementMediatype,
      DbFields.statementAuthor: statementAuthor,
      DbFields.statementLink: statementLink,
      DbFields.statementRectification: statementRectification,
      DbFields.statementPictureCopyright: samplePictureCopyright,
      // DbFields.statementPictureFile: {"file": statementPictureURL}
    }
  };

  if (uploadImage != null) {
    MultipartFile multipartFile = MultipartFile.fromBytes(
      DbFields.statementPicture,
      uploadImage!.toList(),
      filename: '${DateTime.now().second}.jpg',
      contentType: MediaType("image", "jpg"),
    );
    vars["fields"][DbFields.statementPictureFile] = {"upload": multipartFile};
  }

  //add factchecks if not empty
  if (statementFactchecks.facts.isNotEmpty) {
    vars["fields"][DbFields.statementFactcheckIDs] = {};
    vars["fields"][DbFields.statementFactcheckIDs]["createAndAdd"] =
        statementFactchecks.toMap();
  }
  //add object id if we want to update statements
  if (objectId != null) {
    vars["id"] = objectId;
  }
  return vars;
}
```







