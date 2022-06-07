import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:fact_browser/constants/constants.dart';
import 'package:fact_browser/models/statement.dart';
import 'package:fact_browser/provider/device_type_provider.dart';
import 'package:fact_browser/widgets/display/dialogs/correctness_badge.dart';
import 'package:fact_browser/widgets/link_alert.dart';
import 'package:fact_browser/widgets/main_app_bar.dart';
import 'package:transparent_image/transparent_image.dart';
import '../widgets/display/fact_display_container.dart';

/// The page to display all details of a [Statement].
//ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen(
      {Key? key,
      required this.statement,
      required this.onLogin,
      required this.title,
      required this.isLoggedIn})
      : super(key: key);

  /// Stores if user is logged in.
  final bool isLoggedIn;

  /// The statement to be displayed.
  Statement statement;

  /// The title for the appBar, currently not displayed.
  final String title;

  /// Callback for login request. This function is passed to the appBar.
  final Function onLogin;

  @override
  Widget build(BuildContext context) {
    // List of widgets displaying all factchecks.
    List<Widget> factContainers = List.generate(
      statement.statementFactchecks.facts.length,
      (int i) => FactDisplayContainer(
        fact: statement.statementFactchecks.facts[i],
      ),
    );

    return Scaffold(
      appBar: MainAppBar(
        title: title,
        onLogin: onLogin,
        loggedIn: isLoggedIn,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          constraints: const BoxConstraints(maxWidth: 1000),
          height: DeviceType.height(context),
          // Scrollable container displaying all the information.
          child: ScrollConfiguration(
            behavior:
                ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView(
              clipBehavior: Clip.none,
              shrinkWrap: true,
              children: AnimationConfiguration.toStaggeredList(
                duration: const Duration(milliseconds: 400),
                childAnimationBuilder: (widget) => SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: widget,
                  ),
                ),
                children: [
                  // The backbutton.
                  FractionallySizedBox(
                    widthFactor: 1.1,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 40, top: 20, bottom: 20),
                      child: Wrap(
                        children: [
                          TextButton.icon(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: Icon(
                              Icons.arrow_back,
                              color: DesignColors.black,
                            ),
                            label: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Text(
                                "zurück zur Suche",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    // Grey background box.
                    child: Container(
                      alignment: Alignment.topLeft,
                      clipBehavior: Clip.none,
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        color: DesignColors.lightGrey,
                      ),
                      child: FractionallySizedBox(
                        widthFactor:
                            DeviceType.width(context) < 600 ? 1.22 : 1.1,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: FractionallySizedBox(
                                    widthFactor: DeviceType.width(context) < 600
                                        ? 0.8
                                        : 0.5,
                                    child: Stack(
                                      alignment: Alignment.bottomCenter,
                                      children: [
                                        // The image with rounded edges and cropped
                                        // to 4:3 ratio.
                                        Tooltip(
                                          message: "Klicken zum Vergrößern.",
                                          child: InkWell(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            onTap: () => showImage(context),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: AspectRatio(
                                                aspectRatio: 4 / 3,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child:
                                                      FadeInImage.memoryNetwork(
                                                    fadeInDuration:
                                                        const Duration(
                                                            milliseconds: 400),
                                                    fadeInCurve:
                                                        Curves.easeInOut,
                                                    fit: BoxFit.cover,
                                                    placeholder:
                                                        kTransparentImage,
                                                    image: statement
                                                                .statementPictureURL !=
                                                            null
                                                        ? statement
                                                            .statementPictureURL!
                                                            .replaceAll(
                                                                "https%3A%2F%2Fparsefiles.back4app.com%2FFeP6gb7k9R2K9OztjKWA1DgYhubqhW0yJMyrHbxH%2F",
                                                                "")
                                                        : "https://quellenreiter.app/assets/logo-pink.png",
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Display [statement.samplePictureCopyright]
                                        Container(
                                          padding: const EdgeInsets.all(2),
                                          color:
                                              const Color.fromARGB(61, 0, 0, 0),
                                          child: SelectableText(
                                            statement.samplePictureCopyright
                                                .trim(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                // Display [statement.statementText] and
                                // [statement.statementCorrectness]
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: FractionallySizedBox(
                                    widthFactor: 0.6,
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Container(
                                            margin:
                                                const EdgeInsets.only(top: 10),
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(10)),
                                              color:
                                                  DesignColors.backgroundBlue,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  statement.statementText,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle2
                                                      ?.copyWith(
                                                          color: DesignColors
                                                              .lightGrey),
                                                ),
                                                LinkAlert(
                                                    link:
                                                        statement.statementLink,
                                                    msg:
                                                        "Vorsicht! Du verlässt diese Seite und wirst zu einer archivierten vollständigen Version dieser Aussage weitergeleitet. Die Inhalte können möglicherweise verstörend oder diskriminierend sein. Inhalte, die mit dem Label “Unbelegt”, “Falscher Kontext”, “Manipuliert”, “Irreführend” oder “Frei erfunden” gekennzeichnet wurden, enthalten Desinformationen und sind keine verlässliche Quelle. Vollständiger Link:"),
                                              ],
                                            ),
                                          ),
                                          CorrectnessBadge(
                                            correctnessValue:
                                                statement.statementCorrectness,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // Display more information.
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: Flex(
                                direction: DeviceType.width(context) < 400
                                    ? Axis.vertical
                                    : Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Author
                                      Row(
                                        children: [
                                          const Icon(Icons.person),
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 3),
                                              child: Text(
                                                  statement.statementAuthor)),
                                        ],
                                      ),
                                      DeviceType.width(context) < 400
                                          ? const SizedBox.shrink()
                                          : const Divider(
                                              height: 20,
                                            ),
                                      // Media and Mediatype
                                      Row(
                                        children: [
                                          const Icon(Icons.newspaper),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: Text(statement
                                                    .statementMedia +
                                                ' | ' +
                                                statement.statementMediatype),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Date
                                      Row(
                                        children: [
                                          const Icon(Icons.calendar_month),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: SelectableText(
                                                statement.dateAsString()),
                                          ),
                                        ],
                                      ),
                                      DeviceType.width(context) < 400
                                          ? const SizedBox.shrink()
                                          : const Divider(
                                              height: 20,
                                            ),
                                      // Language
                                      Row(
                                        children: [
                                          const Icon(Icons.language),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 3),
                                            child: SelectableText(
                                                statement.statementLanguage),
                                          ),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70),
                    child: Row(children: [
                      Text(
                        "Artikel die belegen, dass diese Aussage als ",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                      CorrectnessBadge(
                          correctnessValue: statement.statementCorrectness),
                      Text(
                        " einzuordnen ist:",
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ]),
                  ),
                  // Display all [statement.factChecks]
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: factContainers,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void showImage(BuildContext context) {
    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(alignment: Alignment.centerLeft, children: [
            FadeInImage.memoryNetwork(
              fadeInDuration: const Duration(milliseconds: 400),
              fadeInCurve: Curves.easeInOut,
              fit: BoxFit.cover,
              placeholder: kTransparentImage,
              image: statement.statementPictureURL != null
                  ? statement.statementPictureURL!.replaceAll(
                      "https%3A%2F%2Fparsefiles.back4app.com%2FFeP6gb7k9R2K9OztjKWA1DgYhubqhW0yJMyrHbxH%2F",
                      "")
                  : "https://quellenreiter.app/assets/logo-pink.png",
            ),
            // Display [statement.samplePictureCopyright]
            RotatedBox(
              quarterTurns: 1,
              child: Container(
                padding: const EdgeInsets.all(2),
                color: const Color.fromARGB(61, 0, 0, 0),
                child: SelectableText(
                  statement.samplePictureCopyright.trim(),
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: const Icon(Icons.close),
                iconSize: 50,
                onPressed: () => Navigator.of(context).pop(context),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
