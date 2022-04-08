


# build method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Widget](https://api.flutter.dev/flutter/widgets/Widget-class.html) build
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)

_override_



<p>Called by the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> to obtain the widget tree that represents the
current state.</p>
<p>This is called whenever the <a href="https://api.flutter.dev/flutter/dart-async/Future-class.html">Future</a>s returned by <a href="https://api.flutter.dev/flutter/widgets/RouterDelegate/setInitialRoutePath.html">setInitialRoutePath</a>,
<a href="../../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/setNewRoutePath.md">setNewRoutePath</a>, or <a href="https://api.flutter.dev/flutter/widgets/RouterDelegate/setRestoredRoutePath.html">setRestoredRoutePath</a> complete as well as when this
notifies its clients (see the <a href="https://api.flutter.dev/flutter/foundation/Listenable-class.html">Listenable</a> interface, which this interface
includes). In addition, it may be called at other times. It is important,
therefore, that the methods above do not update the state that the <a href="../../navigation_fact_browser_router_delegate/FactBrowserRouterDelegate/build.md">build</a>
method uses before they complete their respective futures.</p>
<p>Typically this method returns a suitably-configured <a href="https://api.flutter.dev/flutter/widgets/Navigator-class.html">Navigator</a>. If you do
plan to create a navigator, consider using the
<a href="https://api.flutter.dev/flutter/widgets/PopNavigatorRouterDelegateMixin-mixin.html">PopNavigatorRouterDelegateMixin</a>. If state restoration is enabled for the
<a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a> using this delegate, consider providing a non-null
<a href="https://api.flutter.dev/flutter/widgets/Navigator/restorationScopeId.html">Navigator.restorationScopeId</a> to the <a href="https://api.flutter.dev/flutter/widgets/Navigator-class.html">Navigator</a> returned by this method.</p>
<p>This method must not return null.</p>
<p>The <code>context</code> is the <a href="https://api.flutter.dev/flutter/widgets/Router-class.html">Router</a>'s build context.</p>



## Implementation

```dart
@override
Widget build(BuildContext context) {
  return Navigator(
    pages: [
      MaterialPage(
        key: const ValueKey('SearchPage'),
        child: HomeScreen(
          title: "Search",
          onSelectStatement: _onSelectStatement,
          onQueryChanged: _onQueryChanged,
          onLogin: _onLogin,
          query: null,
          isLoggedIn: loggedIn,
          createStatement: _createStatement,
        ),
      ),
      // If user wants to login, show login page.
      if (_showLogIn)
        MaterialPage(
          key: const ValueKey('LoginPage'),
          child: LoginScreen(
            loginCallback: _loginPageCallback,
          ),
        )
      // If given link is unknown, show the search/home screen.
      else if (_show404)
        MaterialPage(
          key: const ValueKey('Unknown Page'),
          child: HomeScreen(
            title: "Unbekannter Link",
            onSelectStatement: _onSelectStatement,
            onQueryChanged: _onQueryChanged,
            query: _query,
            onLogin: _onLogin,
            isLoggedIn: loggedIn,
            createStatement: _createStatement,
          ),
        )
      // If user is not logged in, but a statement is selected, show the
      // detail page.
      else if (_statement != null && !loggedIn)
        MaterialPage(
          key: const ValueKey('DetailPage'),
          child: DetailScreen(
            title: "Detailansicht. Zum bearbeiten einloggen.",
            onLogin: _onLogin,
            statement: _statement!,
            isLoggedIn: _isLoggedIn,
          ),
        )
      // If user is logged in and a statement is selected, show edit page.
      else if (_statement != null && loggedIn)
        MaterialPage(
          key: const ValueKey('EditPage'),
          child: EditScreen(
            title: "Eingeloggt. Bearbeitungsmodus.",
            onLogin: _onLogin,
            statement: _statement!,
            isLoggedIn: _isLoggedIn,
          ),
        )
      // If user is logged in and an empty statement is selected, show the
      // edit page.
      else if (_emptyStatement != null && loggedIn)
        MaterialPage(
          key: const ValueKey('CreatePage'),
          child: EditScreen(
            title: "Neues Statement erstellen.",
            onLogin: _onLogin,
            statement: _emptyStatement!,
            isLoggedIn: _isLoggedIn,
          ),
        ),
    ],
    // Define what happens on Navigator.pop() or back button.
    onPopPage: (route, result) {
      if (!route.didPop(result)) {
        return false;
      }
      _query = null;
      _statement = null;
      _emptyStatement = null;
      _showLogIn = false;

      notifyListeners();
      return true;
    },
  );
}
```







