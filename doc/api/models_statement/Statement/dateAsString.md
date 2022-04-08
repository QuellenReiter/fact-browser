


# dateAsString method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) dateAsString
()





<p>Return the <a href="../../models_statement/Statement/statementDay.md">Statement.statementDay</a>, <a href="../../models_statement/Statement/statementMonth.md">Statement.statementMonth</a> and
<a href="../../models_statement/Statement/statementYear.md">Statement.statementYear</a> as <a href="https://api.flutter.dev/flutter/dart-core/String-class.html">String</a> like so dd/mm/yyyy.</p>
<p>If no <a href="../../models_statement/Statement/statementDay.md">Statement.statementDay</a> and/or no <a href="../../models_statement/Statement/statementMonth.md">Statement.statementMonth</a> is
given, the returned <a href="https://api.flutter.dev/flutter/dart-core/String-class.html">String</a> ommits these fields like so mm/yyyy or yyyy.</p>



## Implementation

```dart
String dateAsString() {
  String ret = "";
  if (statementDay != 0) {
    ret += statementDay.toString().padLeft(2, "0") + '/';
  }
  if (statementMonth != 0) {
    ret += statementMonth.toString().padLeft(2, "0") + '/';
  }
  if (statementYear != 0) {
    ret += statementYear.toString();
  }
  return ret;
}
```







