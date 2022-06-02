import 'package:flutter/material.dart';
import 'package:fact_browser/constants/constants.dart';
import 'package:fact_browser/provider/device_type_provider.dart';
import 'package:url_launcher/url_launcher.dart';

/// The AppBar (top of the App) that contains searchbar and links to impressum, datenschutz and
/// login/logout.
/// TODO: Remove large if statement and do condition: popupmenu or row.
class MainAppBar extends StatefulWidget with PreferredSizeWidget {
  MainAppBar({
    Key? key,
    required this.title,
    required this.onLogin,
    required this.loggedIn,
  }) : super(key: key);

  /// Page title, currently not displayed.
  final String title;

  /// Stores if user is logged in.
  final bool loggedIn;

  /// Callback, if user requests login.
  final Function onLogin;

  /// The height of the appBar.
  double barHeight = 150;

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  /// The size of the appbar.
  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}

/// State of the [MainAppBar].
class _MainAppBarState extends State<MainAppBar> {
  @override
  // Build the appBar
  Widget build(BuildContext context) {
    // If mobile or narrow desktop browser. Main difference:
    // Narrow windows show a dropdown for login/impressum/datenschutz.
    return Container(
      height: DeviceType.width(context) < 600 ? 70 : null,
      // Set background color and rounded bottom corners.
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(DeviceType.width(context) < 600 ? 15 : 40)),
        color: DesignColors.backgroundBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: DeviceType.width(context) < 600 ? 5 : 20),
            child:
                // The app icon. If tabbed, returns to homescreen.
                InkWell(
              onTap: () {
                Navigator.of(context).pop(context);
              },
              child: const Image(
                image: AssetImage('assets/logo-pink.png'),
              ),
            ),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // The Title and subtitle.
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SelectableText(
                        'FACT BROWSER',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      SelectableText('Die "Fake News"-Datenbank',
                          style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                ),
              ],
            ),
          ),
          DeviceType.width(context) < 900
              ?
              // The dropdown menu for login, impressum and datenschutz.
              PopupMenuButton(
                  itemBuilder: (context) => [
                    // Item: Login/Logout
                    PopupMenuItem(
                      onTap: () => widget.onLogin(),
                      child: widget.loggedIn
                          ? Text(
                              "Logout",
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          : Text(
                              "Login",
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                      value: 1,
                    ),
                    // Item: Impressum
                    PopupMenuItem(
                      onTap: () async {
                        if (!await launch(
                            "https://quellenreiter.app/Impressum/")) {
                          throw 'could not launch';
                        }
                      },
                      child: Text(
                        "Impressum",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      value: 2,
                    ),
                    // Item: Datenschutz
                    PopupMenuItem(
                      onTap: () async {
                        if (!await launch(
                            "https://quellenreiter.app/Datenschutz/")) {
                          throw 'could not launch';
                        }
                      },
                      child: Text(
                        "Datenschutz",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      value: 2,
                    )
                  ],
                )
              : Row(
                  children: [
                    // Item: Login/Logout
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: InkWell(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.login,
                              color: DesignColors.lightBlue,
                            ),
                            widget.loggedIn
                                ? Text(
                                    "Logout",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                : Text(
                                    "Login",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ),
                          ],
                        ),
                        onTap: () => widget.onLogin(),
                      ),
                    ),
                    // Item: Impressum and Datenschutz
                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () async {
                              if (!await launch(
                                  "https://quellenreiter.app/Impressum/")) {
                                throw 'could not launch';
                              }
                            },
                            child: Text(
                              "Impressum",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (!await launch(
                                  "https://quellenreiter.app/Datenschutz/")) {
                                throw 'could not launch';
                              }
                            },
                            child: Text(
                              "Datenschutz",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
