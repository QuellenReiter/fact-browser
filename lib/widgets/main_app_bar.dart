import 'package:flutter/material.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
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
    this.searchController,
  }) : super(key: key);

  /// Page title, currently not displayed.
  final String title;

  /// Stores if user is logged in.
  final bool loggedIn;

  /// Callback, if user requests login.
  final Function onLogin;

  /// The controller of the searchbar content and input.
  final TextEditingController? searchController;

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
      // Set background color and rounded bottom corners.
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
        color: Color(0xFF0999bc),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40, top: 0),
            child:
                // The app icon. If tabbed, returns to homescreen.
                InkWell(
              onTap: () {
                Navigator.pop(context);
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
                // Display the searchbar, if [widget.searchController] exists.
                widget.searchController != null
                    ? Container(
                        padding: const EdgeInsets.all(10),
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: TextField(
                          controller: widget.searchController,
                          style: Theme.of(context).textTheme.bodyText2,
                          decoration: const InputDecoration(
                            hintText: "Suche nach Themen, z.B. Corona",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                gapPadding: 2),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
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
                          ? SelectableText(
                              "Logout",
                              style: Theme.of(context).textTheme.subtitle2,
                            )
                          : SelectableText(
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
                      child: SelectableText(
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
                      child: SelectableText(
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
                            const Icon(
                              Icons.login,
                              color: Color(0xFFc7ebeb),
                            ),
                            widget.loggedIn
                                ? SelectableText(
                                    "Logout",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  )
                                : SelectableText(
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
                            child: SelectableText(
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
                            child: SelectableText(
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
