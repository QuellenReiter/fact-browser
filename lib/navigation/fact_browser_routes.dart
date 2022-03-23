class FactBrowserRoutePath {
  final String? statementID;
  final bool isUnknown;

  FactBrowserRoutePath.home()
      : statementID = null,
        isUnknown = false;
  FactBrowserRoutePath.details(this.statementID) : isUnknown = false;
  FactBrowserRoutePath.unknown()
      : statementID = null,
        isUnknown = true;

  bool get isHomePage => statementID == null;
  bool get isDetailsPage => statementID != null;
}
