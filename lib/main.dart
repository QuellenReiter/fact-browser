import 'package:flutter/material.dart';
import 'package:fact_browser/constants/constants.dart';
import 'package:fact_browser/navigation/fact_browser_rout_information_parser.dart';
import 'package:fact_browser/navigation/fact_browser_router_delegate.dart';
import 'package:fact_browser/provider/device_type_provider.dart';

void main() async {
  runApp(const FactBrowser());
}

/// The main app.
class FactBrowser extends StatefulWidget {
  const FactBrowser({Key? key}) : super(key: key);

  @override
  State<FactBrowser> createState() => _FactBrowserState();
}

/// State of the [FactBrowser].
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
      backButtonDispatcher: RootBackButtonDispatcher(),
      routeInformationParser: _routeInformationParser,
      routerDelegate: _routerDelegate,
      builder: (ctx, child) {
        return Theme(
          child: child!,
          data: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.grey,
            textTheme: TextTheme(

                // Small text for light backgrounds.
                bodyText2: TextStyle(
                  color: DesignColors.black,
                  fontSize: DeviceType.width(ctx) < 600 ? 10 : 14,
                  fontFamily: 'Oswald',
                ),

                // Small text for blue backgrounds.
                bodyText1: TextStyle(
                  // default all text widget
                  fontSize: DeviceType.width(ctx) < 600 ? 10 : 14,
                  fontFamily: 'Oswald',
                  color: DesignColors.lightBlue,
                ),

                // Title in for appBar.
                headline1: TextStyle(
                  fontFamily: 'Bangers',
                  fontSize: DeviceType.width(ctx) < 600 ? 30 : 50,
                  color: DesignColors.lightBlue,
                ),

                // Huge text in bangers font.
                headline3: TextStyle(
                  fontFamily: 'Bangers',
                  fontSize: DeviceType.width(ctx) < 600 ? 24 : 40,
                  color: DesignColors.lightGrey,
                ),

                // Large font for subtitles on blue backgrounds.
                subtitle1: TextStyle(
                  fontFamily: 'Oswald',
                  color: DesignColors.lightBlue,
                  fontSize: DeviceType.width(ctx) < 600 ? 12 : 20,
                ),

                // X-Large font for subtitles on light backgrounds.
                subtitle2: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: DeviceType.width(ctx) < 600 ? 14 : 24,
                ),

                // Large font for subtitles on light backgrounds.
                headline2: TextStyle(
                  fontFamily: 'Oswald',
                  fontSize: DeviceType.width(ctx) < 600 ? 12 : 20,
                )),
            // fill back inside all TextFormField
            inputDecorationTheme: const InputDecorationTheme(
              isDense: true,
            ),
          ),
        );
      },
    );
  }
}
