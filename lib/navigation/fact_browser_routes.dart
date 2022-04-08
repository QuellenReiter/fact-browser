import '../models/statement.dart';

/// Class defining all Routes (Pages) in the Fact Browser app.
class FactBrowserRoutePath {
  ///  The objectId of the statement. Only set, if on detail or edit page.
  final String? statementID;

  /// Set if given Route (Deep Link) is wrong.
  final bool isUnknown;

  /// Stores wether the user is logged in.
  final bool isLoggedIn;

  /// An empty [Statement] is set when on the create page.
  final Statement? emptyStatement;

  /// Stores if the Login button was pressed and thus the Login page
  /// should be displayed.
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

  /// Currently on Home Page?
  bool get isHomePage => statementID == null;

  /// Currently on Detail Page?
  bool get isDetailsPage => statementID != null;

  /// Currently on Edit Page?
  bool get isEditPage => statementID != null && isLoggedIn == true;

  /// Currently on Create Page?
  bool get isCreatePage => emptyStatement != null;

  /// Currently on Legin Page?
  bool get isLoginPage => showLogIn == true;
}
