import 'package:flutter/material.dart';
import 'package:fact_browser/models/statement.dart';
import 'package:fact_browser/navigation/fact_browser_routes.dart';
import 'package:fact_browser/provider/database_utils.dart';
import 'package:fact_browser/screens/detail_screen.dart';
import '../screens/edit_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class FactBrowserRouterDelegate extends RouterDelegate<FactBrowserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FactBrowserRoutePath> {
  @override
  final GlobalKey<NavigatorState> navigatorKey;

  final db = DatabaseUtils();
  Statement? _statement;
  Statements? _statements;
  Statement? _emptyStatement;
  String? _query;
  bool _show404 = false;
  bool _showLogIn = false;
  bool _isLoggedIn = false;
  bool get loggedIn => _isLoggedIn;
  set loggedIn(value) {
    _isLoggedIn = value;
    notifyListeners();
  }

  FactBrowserRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
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

  /// Function that handles taps on statement cards and sets [_statement].
  void _onSelectStatement(Statement statement) {
    _statement = statement;
    notifyListeners();
  }

  /// Function that handles the search queries.
  void _onQueryChanged(String? query) async {
    // If query is null, make it empty
    query ?? "";
    _query = query;
    _statements = await db.searchStatements(query);
    notifyListeners();
  }

  /// Function that handles taps on the login/logout button.
  ///
  /// The user is logged out, when already logged in. If User is logged out,
  /// a login with an existing stored token is attempted and if this fails,
  /// the login page is shown.
  void _onLogin() async {
    final db = DatabaseUtils();
    // logout if user is logged in
    if (_isLoggedIn) {
      await db.logout();
      _isLoggedIn = false;
      notifyListeners();
      return;
    } else {
      // Check if user can be logged in with an existing token.
      _isLoggedIn = await db.checkToken();
    }
    // If not, show the login page.
    if (!_isLoggedIn) {
      //show login page
      _showLogIn = true;
    }

    notifyListeners();
  }

  /// Callback that is passed to the Login page and called with the result of
  /// the login attempt.
  void _loginPageCallback(bool success) async {
    if (success) {
      _isLoggedIn = true;
      _showLogIn = false;
    }
    notifyListeners();
  }

  /// Function that creates an empty statement and is called when the User
  /// taps the create statement button.
  void _createStatement() {
    _emptyStatement = Statement.empty();
    notifyListeners();
  }

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
            statements: _statements,
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
              statements: _statements,
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
        _statement = null;
        _emptyStatement = null;
        _showLogIn = false;
        notifyListeners();
        return true;
      },
    );
  }

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
}
