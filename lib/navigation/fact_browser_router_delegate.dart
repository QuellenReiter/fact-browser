import 'dart:html';

import 'package:flutter/material.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/navigation/fact_browser_routes.dart';
import 'package:statementmanager/provider/database_utils.dart';

import '../screens/detail_screen.dart';
import '../screens/home_screen.dart';

class FactBrowserRouterDelegate extends RouterDelegate<FactBrowserRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<FactBrowserRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;

  Statement? _statement;
  String? _query;
  bool show404 = false;

  FactBrowserRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  FactBrowserRoutePath get currentConfiguration {
    if (show404) {
      return FactBrowserRoutePath.unknown();
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
            query: null,
          ),
        ),
        if (show404)
          MaterialPage(
            key: const ValueKey('Unknown Page'),
            child: HomeScreen(
              title: "Unbekannter Link",
              onSelectStatement: _onSelectStatement,
              onQueryChanged: _onQueryChanged,
              query: _query,
            ),
          )
        else if (_statement != null)
          MaterialPage(
            key: const ValueKey('DetailPage'),
            child: DetailScreen(
              statement: _statement!,
            ),
          ),
      ],
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        _query = null;
        _statement = null;

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
      show404 = true;
      return;
    }
    Statement? statement = await db.getStatement(configuration.statementID);
    if (configuration.isDetailsPage) {
      // check if statement exists here
      if (statement == null) {
        show404 = true;
        return;
      }
      // fetch statement from DB here
      _statement = statement;
    } else {
      _statement = null;
    }

    show404 = false;
  }
}
