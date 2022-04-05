import 'package:flutter/material.dart';
import 'package:statementmanager/navigation/fact_browser_rout_information_parser.dart';
import 'package:statementmanager/navigation/fact_browser_router_delegate.dart';
import 'package:statementmanager/provider/device_type_provider.dart';

void main() async {
  runApp(const FactBrowser());
}

class FactBrowser extends StatefulWidget {
  const FactBrowser({Key? key}) : super(key: key);

  @override
  State<FactBrowser> createState() => _FactBrowserState();
}

class _FactBrowserState extends State<FactBrowser> {
  final FactBrowserRouterDelegate _routerDelegate = FactBrowserRouterDelegate();
  final FactBrowserRouteInformationParser _routeInformationParser =
      FactBrowserRouteInformationParser();

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // link to the API
    return MaterialApp.router(
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.grey,

        textTheme: const TextTheme(
            bodyText2: TextStyle(
              // default all text widget
              fontSize: 12.0,
              fontFamily: 'Oswald',
            ),
            bodyText1: TextStyle(
              // default all text widget
              fontSize: 12.0,
              fontFamily: 'Oswald',
            ),
            headline1: TextStyle(
              fontFamily: 'Bangers',
              fontSize: 50,
              color: Color(0xFFc7ebeb),
            ),
            subtitle1: TextStyle(
              fontFamily: 'Oswald',
              color: Color(0xFFc7ebeb),
              fontSize: 16,
            ),
            subtitle2: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 16,
            ),
            headline2: TextStyle(
              fontFamily: 'Oswald',
              fontSize: 16,
            )),
        // fill back inside all TextFormField
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
        ),
      ),
      // home: GraphQLProvider(

      //   client: client,
      // ),
    );
  }
}
