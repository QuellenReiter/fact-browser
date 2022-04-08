


# setNewRoutePath method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> setNewRoutePath
([FactBrowserRoutePath](../../navigation_fact_browser_routes/FactBrowserRoutePath-class.md) configuration)

_override_



<p>Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> when the <a href="https://api.flutter.dev/flutter/widgets/Router/routeInformationProvider.html">Router.routeInformationProvider</a> reports that a
new route has been pushed to the application by the operating system.</p>
<p>Consider using a <a href="https://api.flutter.dev/flutter/foundation/SynchronousFuture-class.html">SynchronousFuture</a> if the result can be computed
synchronously, so that the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> does not need to wait for the next
microtask to schedule a build.</p>



## Implementation

```dart
@override
Future<void> setNewRoutePath(FactBrowserRoutePath configuration) async {
  var db = DatabaseUtils();
  if (configuration.isUnknown) {
    _statement = null;
    _show404 = true;
    return;
  }
  // Download the statement before opening the detail page.
  Statement? statement = await db.getStatement(configuration.statementID);
  if (configuration.isDetailsPage) {
    // check if statement exists here
    if (statement == null) {
      _show404 = true;
      return;
    }
    // fetch statement from DB here
    _statement = statement;
  } else {
    _statement = null;
  }

  _show404 = false;
}
```







