import 'package:flutter/material.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainAppBar extends StatefulWidget with PreferredSizeWidget {
  MainAppBar({
    Key? key,
    required this.title,
    required this.onLogin,
    required this.loggedIn,
    this.searchController,
  }) : super(key: key);

  final String title;
  final bool loggedIn;
  final Function onLogin;
  final TextEditingController? searchController;
  double barHeight = 150;

  @override
  State<MainAppBar> createState() => _MainAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    if (DeviceType.width(context) < 900) {
      return Container(
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
              child: InkWell(
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
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'FACT BROWSER',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                        Text('Die "Fake News"-Datenbank',
                            style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                  ),
                  widget.searchController != null
                      ? Container(
                          padding: const EdgeInsets.all(10),
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
            PopupMenuButton(
              itemBuilder: (context) => [
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
                PopupMenuItem(
                  onTap: () async {
                    if (!await launch("https://quellenreiter.app/Impressum/")) {
                      throw 'could not launch';
                    }
                  },
                  child: Text(
                    "Impressum",
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  value: 2,
                ),
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
            ),
          ],
        ),
      );
    } else {
      return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
          color: Color(0xFF0999bc),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Image(
                        image: AssetImage('assets/logo-pink.png'),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'FACT BROWSER',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                          Text('Die "Fake News"-Datenbank',
                              style: Theme.of(context).textTheme.subtitle1),
                        ],
                      ),
                      widget.searchController != null
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              constraints: const BoxConstraints(
                                maxWidth: 500,
                              ),
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
                  Row(
                    children: [
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
            ),
          ],
        ),
      );
    }
  }
}
