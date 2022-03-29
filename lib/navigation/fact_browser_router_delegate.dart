import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/navigation/fact_browser_routes.dart';
import 'package:statementmanager/provider/database_utils.dart';
import 'package:statementmanager/screens/detail_screen.dart';

import '../screens/edit_screen.dart';
import '../screens/home_screen.dart';
import '../screens/login_screen.dart';

class FactBrowserRouterDelegate extends RouterDelegate<FactBrowserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FactBrowserRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  Statement? _statement;
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

  FactBrowserRoutePath get currentConfiguration {
    if (_show404) {
      return FactBrowserRoutePath.unknown();
    } else if (_showLogIn)
      return FactBrowserRoutePath.login();
    else if (_emptyStatement != null) {
      return FactBrowserRoutePath.create(_emptyStatement);
    }

    return _statement == null
        ? FactBrowserRoutePath.home()
        : FactBrowserRoutePath.details(_statement?.objectId);
  }

  void _onSelectStatement(Statement statement) {
    _statement = statement;
    notifyListeners();
  }

  void _onQueryChanged(String query) {
    _query = query;
    notifyListeners();
  }

  void _onLogin() async {
    final db = DatabaseUtils();
    // logout if user is logged in
    if (_isLoggedIn) {
      await db.logout();
      _isLoggedIn = false;
      notifyListeners();
      return;
    }
    // implement properly !!!
    _isLoggedIn = await db.checkToken();

    if (!_isLoggedIn) {
      //show login page
      _showLogIn = true;
    }

    notifyListeners();
  }

  void _loginPageCallback(bool success) async {
    if (success) {
      _isLoggedIn = true;
      _showLogIn = false;
    }
    notifyListeners();
  }

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
            isLoggedIn: loggedIn,
            createStatement: _createStatement,
          ),
        ),
        if (_showLogIn)
          MaterialPage(
            key: const ValueKey('LoginPage'),
            child: LoginScreen(
              loginCallback: _loginPageCallback,
            ),
          )
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
        else if (_statement != null && !loggedIn)
          MaterialPage(
            key: const ValueKey('DetailPage'),
            child: DetailScreen(
              title: "Detailansicht. Zum bearbeiten einloggen.",
              onLogin: _onLogin,
              statement: _statement!,
            ),
          )
        else if (_statement != null && loggedIn)
          MaterialPage(
            key: const ValueKey('EditPage'),
            child: EditScreen(
              title: "Eingeloggt. Bearbeitungsmodus.",
              onLogin: _onLogin,
              statement: _statement!,
            ),
          )
        else if (_emptyStatement != null && loggedIn)
          MaterialPage(
            key: const ValueKey('CreatePage'),
            child: EditScreen(
              title: "Neues Statement erstellen.",
              onLogin: _onLogin,
              statement: _emptyStatement!,
            ),
          ),
      ],
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

  @override
  Future<void> setNewRoutePath(FactBrowserRoutePath configuration) async {
    var db = DatabaseUtils();
    if (configuration.isUnknown) {
      _statement = null;
      _show404 = true;
      return;
    }
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
