


# restoreRouteInformation method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[RouteInformation](https://api.flutter.dev/flutter/widgets/RouteInformation-class.html)? restoreRouteInformation
([FactBrowserRoutePath](../../navigation_fact_browser_routes/FactBrowserRoutePath-class.md) configuration)

_override_



<p>Restore the route information from the given configuration.</p>
<p>This may return null, in which case the browser history will not be
updated and state restoration is disabled. See <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a>'s documentation
for details.</p>
<p>The <a href="../../navigation_fact_browser_rout_information_parser/FactBrowserRouteInformationParser/parseRouteInformation.md">parseRouteInformation</a> method must produce an equivalent
configuration when passed this method's return value.</p>



## Implementation

```dart
@override
RouteInformation? restoreRouteInformation(
    FactBrowserRoutePath configuration) {
  if (configuration.isUnknown) {
    return const RouteInformation(location: '/');
  }
  if (configuration.isHomePage) {
    return const RouteInformation(location: '/');
  }
  if (configuration.isDetailsPage) {
    return RouteInformation(
        location: '/statement/${configuration.statementID}');
  }
  return null;
}
```







