


# FactBrowserRouterDelegate class






    *[<Null safety>](https://dart.dev/null-safety)*





**Inheritance**

- [Object](https://api.flutter.dev/flutter/dart-core/Object-class.html)
- [Listenable](https://api.flutter.dev/flutter/foundation/Listenable-class.html)
- [RouterDelegate](https://api.flutter.dev/flutter/widgets/RouterDelegate-class.html)&lt;[FactBrowserRoutePath](../navigation_fact_browser_routes/FactBrowserRoutePath-class.md)>
- FactBrowserRouterDelegate


**Mixed in types**

- [ChangeNotifier](https://api.flutter.dev/flutter/foundation/ChangeNotifier-class.html)
- [PopNavigatorRouterDelegateMixin](https://api.flutter.dev/flutter/widgets/PopNavigatorRouterDelegateMixin-mixin.html)&lt;[FactBrowserRoutePath](../navigation_fact_browser_routes/FactBrowserRoutePath-class.md)>




## Constructors

[FactBrowserRouterDelegate](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/FactBrowserRouterDelegate.md) ()

    


## Properties

##### [currentConfiguration](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/currentConfiguration.md) &#8594; [FactBrowserRoutePath](../navigation_fact_browser_routes/FactBrowserRoutePath-class.md)



Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> when it detects a route information may have
changed as a result of rebuild. [...](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/currentConfiguration.md)  
_read-only, override_



##### [hashCode](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html)  
_read-only, inherited_



##### [hasListeners](https://api.flutter.dev/flutter/foundation/ChangeNotifier/hasListeners.html) &#8594; [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



Whether any listeners are currently registered. [...](https://api.flutter.dev/flutter/foundation/ChangeNotifier/hasListeners.html)  
_@[protected](https://pub.dev/documentation/meta/1.7.0/meta/protected-constant.html), read-only, inherited_



##### [loggedIn](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/loggedIn.md) &#8596; [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



   
_read / write_



##### [navigatorKey](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/navigatorKey.md) &#8594; [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[NavigatorState](https://api.flutter.dev/flutter/widgets/NavigatorState-class.html)>



The key used for retrieving the current navigator. [...](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/navigatorKey.md)  
_final_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_




## Methods

##### [addListener](https://api.flutter.dev/flutter/foundation/ChangeNotifier/addListener.html)([VoidCallback](https://api.flutter.dev/flutter/dart-ui/VoidCallback.html) listener) void



Register a closure to be called when the object changes. [...](https://api.flutter.dev/flutter/foundation/ChangeNotifier/addListener.html)  
_inherited_



##### [build](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/build.md)([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context) [Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html)



Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> to obtain the widget tree that represents the
current state. [...](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/build.md)  
_override_



##### [dispose](https://api.flutter.dev/flutter/foundation/ChangeNotifier/dispose.html)() void



Discards any resources used by the object. After this is called, the
object is not in a usable state and should be discarded (calls to
<a href="https://api.flutter.dev/flutter/foundation/ChangeNotifier/addListener.html">addListener</a> and <a href="https://api.flutter.dev/flutter/foundation/ChangeNotifier/removeListener.html">removeListener</a> will throw after the object is
disposed). [...](https://api.flutter.dev/flutter/foundation/ChangeNotifier/dispose.html)  
_@[mustCallSuper](https://pub.dev/documentation/meta/1.7.0/meta/mustCallSuper-constant.html), inherited_



##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [notifyListeners](https://api.flutter.dev/flutter/foundation/ChangeNotifier/notifyListeners.html)() void



Call all the registered listeners. [...](https://api.flutter.dev/flutter/foundation/ChangeNotifier/notifyListeners.html)  
_@[protected](https://pub.dev/documentation/meta/1.7.0/meta/protected-constant.html), @[visibleForTesting](https://pub.dev/documentation/meta/1.7.0/meta/visibleForTesting-constant.html), inherited_



##### [popRoute](https://api.flutter.dev/flutter/widgets/PopNavigatorRouterDelegateMixin/popRoute.html)() [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)>



Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> when the <a href="https://api.flutter.dev/flutter/widgets/Router/backButtonDispatcher.html">Router.backButtonDispatcher</a> reports that
the operating system is requesting that the current route be popped. [...](https://api.flutter.dev/flutter/widgets/PopNavigatorRouterDelegateMixin/popRoute.html)  
_inherited_



##### [removeListener](https://api.flutter.dev/flutter/foundation/ChangeNotifier/removeListener.html)([VoidCallback](https://api.flutter.dev/flutter/dart-ui/VoidCallback.html) listener) void



Remove a previously registered closure from the list of closures that are
notified when the object changes. [...](https://api.flutter.dev/flutter/foundation/ChangeNotifier/removeListener.html)  
_inherited_



##### [setInitialRoutePath](https://api.flutter.dev/flutter/widgets/RouterDelegate/setInitialRoutePath.html)([FactBrowserRoutePath](../navigation_fact_browser_routes/FactBrowserRoutePath-class.md) configuration) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void>



Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> at startup with the structure that the
<a href="https://api.flutter.dev/flutter/widgets/RouteInformationParser-class.html">RouteInformationParser</a> obtained from parsing the initial route. [...](https://api.flutter.dev/flutter/widgets/RouterDelegate/setInitialRoutePath.html)  
_inherited_



##### [setNewRoutePath](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/setNewRoutePath.md)([FactBrowserRoutePath](../navigation_fact_browser_routes/FactBrowserRoutePath-class.md) configuration) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void>



Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> when the <a href="https://api.flutter.dev/flutter/widgets/Router/routeInformationProvider.html">Router.routeInformationProvider</a> reports that a
new route has been pushed to the application by the operating system. [...](../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/setNewRoutePath.md)  
_override_



##### [setRestoredRoutePath](https://api.flutter.dev/flutter/widgets/RouterDelegate/setRestoredRoutePath.html)([FactBrowserRoutePath](../navigation_fact_browser_routes/FactBrowserRoutePath-class.md) configuration) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void>



Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> during state restoration. [...](https://api.flutter.dev/flutter/widgets/RouterDelegate/setRestoredRoutePath.html)  
_inherited_



##### [toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/dart-core/Object/toString.html)  
_inherited_




## Operators

##### [operator ==](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)  
_inherited_











