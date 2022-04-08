


# parseRouteInformation method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[FactBrowserRoutePath](../../navigation_fact_browser_routes/FactBrowserRoutePath-class.md)> parseRouteInformation
([RouteInformation](https://api.flutter.dev/flutter/widgets/RouteInformation-class.html) routeInformation)

_override_



<p>Converts the given route information into parsed data to pass to a
<a href="https://api.flutter.dev/flutter/widgets/RouterDelegate-class.html">RouterDelegate</a>.</p>
<p>The method should return a future which completes when the parsing is
complete. The parsing may be asynchronous if, e.g., the parser needs to
communicate with the OEM thread to obtain additional data about the route.</p>
<p>Consider using a <a href="https://api.flutter.dev/flutter/foundation/SynchronousFuture-class.html">SynchronousFuture</a> if the result can be computed
synchronously, so that the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> does not need to wait for the next
microtask to pass the data to the <a href="https://api.flutter.dev/flutter/widgets/RouterDelegate-class.html">RouterDelegate</a>.</p>



## Implementation

```dart
@override
Future<FactBrowserRoutePath> parseRouteInformation(
    RouteInformation routeInformation) async {
  // Url to be parsed
  final uri = Uri.parse(routeInformation.location!);
  // Handle '/'
  if (uri.pathSegments.isEmpty) {
    return FactBrowserRoutePath.home();
  }

  // Handle '/book/:id'
  if (uri.pathSegments.length == 2) {
    if (uri.pathSegments[0] != 'statement') {
      return FactBrowserRoutePath.unknown();
    }
    var remaining = uri.pathSegments[1];
    // check if logged in
    // try to login, if usccess return edit page
    return FactBrowserRoutePath.details(remaining);
  }
  // Handle unknown routes
  return FactBrowserRoutePath.unknown();
}
```







