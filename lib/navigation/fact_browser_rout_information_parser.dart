import 'package:flutter/material.dart';
import 'package:fact_browser/navigation/fact_browser_routes.dart';

/// Class to parse given links and direct users to the correct page.
class FactBrowserRouteInformationParser
    extends RouteInformationParser<FactBrowserRoutePath> {
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
}
