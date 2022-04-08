


# dateAsString method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) dateAsString
()





<p>Return the <a href="../../models_fact/Fact/factDay.md">Fact.factDay</a>, <a href="../../models_fact/Fact/factMonth.md">Fact.factMonth</a> and <a href="../../models_fact/Fact/factYear.md">Fact.factYear</a> as
<a href="https://api.flutter.dev/flutter/dart-core/String-class.html">String</a> like so dd/mm/yyyy.</p>
<p>If no <a href="../../models_fact/Fact/factDay.md">Fact.factDay</a> and/or no <a href="../../models_fact/Fact/factMonth.md">Fact.factMonth</a> is given, the returned
<a href="https://api.flutter.dev/flutter/dart-core/String-class.html">String</a> ommits these fields like so mm/yyyy or yyyy.</p>



## Implementation

```dart
String dateAsString() {
  String ret = "";
  if (factDay != 0) {
    ret += factDay.toString().padLeft(2, "0") + '/';
  }
  if (factMonth != 0) {
    ret += factMonth.toString().padLeft(2, "0") + '/';
  }
  if (factYear != 0) {
    ret += factYear.toString();
  }
  return ret;
}
```







