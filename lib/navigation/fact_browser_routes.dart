import '../models/statement.dart';

class FactBrowserRoutePath {
  final String? statementID;
  final bool isUnknown;
  final bool isLoggedIn;
  final Statement? emptyStatement;
  final bool showLogIn;

  FactBrowserRoutePath.create(this.emptyStatement)
      : isLoggedIn = true,
        isUnknown = false,
        statementID = null,
        showLogIn = false;
  FactBrowserRoutePath.edit(this.statementID)
      : isUnknown = false,
        isLoggedIn = true,
        emptyStatement = null,
        showLogIn = false;
  FactBrowserRoutePath.home()
      : statementID = null,
        isUnknown = false,
        isLoggedIn = false,
        emptyStatement = null,
        showLogIn = false;
  FactBrowserRoutePath.details(this.statementID)
      : isUnknown = false,
        isLoggedIn = false,
        emptyStatement = null,
        showLogIn = false;
  FactBrowserRoutePath.unknown()
      : statementID = null,
        isUnknown = true,
        isLoggedIn = false,
        emptyStatement = null,
        showLogIn = false;

  FactBrowserRoutePath.login()
      : statementID = null,
        isUnknown = false,
        isLoggedIn = false,
        emptyStatement = null,
        showLogIn = true;

  bool get isHomePage => statementID == null;
  bool get isDetailsPage => statementID != null;
  bool get isEditPage => statementID != null && isLoggedIn == true;
  bool get isCreatePage => emptyStatement != null;
  bool get isLoginPage => showLogIn == true;
}
