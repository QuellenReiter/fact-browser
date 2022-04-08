


# currentConfiguration property




    *[<Null safety>](https://dart.dev/null-safety)*




[FactBrowserRoutePath](../../navigation_fact_browser_routes/FactBrowserRoutePath-class.md) currentConfiguration
  
_override_



<p>Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> when it detects a route information may have
changed as a result of rebuild.</p>
<p>If this getter returns non-null, the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> will start to report new
route information back to the engine. In web applications, the new
route information is used for populating browser history in order to
support the forward and the backward buttons.</p>
<p>When overriding this method, the configuration returned by this getter
must be able to construct the current app state and build the widget
with the same configuration in the <a href="../../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/build.md">build</a> method if it is passed back
to the <a href="../../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/setNewRoutePath.md">setNewRoutePath</a>. Otherwise, the browser backward and forward
buttons will not work properly.</p>
<p>By default, this getter returns null, which prevents the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> from
reporting the route information. To opt in, a subclass can override this
getter to return the current configuration.</p>
<p>At most one <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> can opt in to route information reporting. Typically,
only the top-most <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> created by <a href="https://api.flutter.dev/flutter/widgets/WidgetsApp/WidgetsApp.router.html">WidgetsApp.router</a> should opt for
route information reporting.</p>
<h2 id="state-restoration">State Restoration</h2>
<p>This getter is also used by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> to implement state restoration.
During state serialization, the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> will persist the current
configuration and during state restoration pass it back to the delegate
by calling <a href="https://api.flutter.dev/flutter/widgets/RouterDelegate/setRestoredRoutePath.html">setRestoredRoutePath</a>.</p>



## Implementation

```dart
@override
FactBrowserRoutePath get currentConfiguration {
  if (_show404) {
    return FactBrowserRoutePath.unknown();
  } else if (_showLogIn) {
    return FactBrowserRoutePath.login();
  } else if (_emptyStatement != null) {
    return FactBrowserRoutePath.create(_emptyStatement);
  }

  return _statement == null
      ? FactBrowserRoutePath.home()
      : FactBrowserRoutePath.details(_statement?.objectId);
}
```








