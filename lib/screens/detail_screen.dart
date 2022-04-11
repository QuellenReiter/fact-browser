import 'package:flutter/material.dart';
import 'package:statementmanager/constants/constants.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:statementmanager/utilities/utilities.dart';
import 'package:statementmanager/widgets/link_alert.dart';
import 'package:statementmanager/widgets/main_app_bar.dart';
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
          child: ListView(
            clipBehavior: Clip.none,
            shrinkWrap: true,
            children: [
              // The backbutton.
              FractionallySizedBox(
                widthFactor: 1.1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 40, top: 20, bottom: 20),
                  child: Wrap(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new),
                        label: Padding(
                          padding: const EdgeInsets.all(7),
                          child: Text(
                            "zurück zur Suche",
                            style: Theme.of(context).textTheme.bodyText2,
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
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: DesignColors.lightGrey,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 1.1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: FractionallySizedBox(
                                widthFactor:
                                    DeviceType.width(context) < 600 ? 0.8 : 0.5,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    // The image with rounded edges and cropped
                                    // to 4:3 ratio.
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: AspectRatio(
                                        aspectRatio: 4 / 3,
                                        child: Container(
                                            decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              statement.statementPictureURL !=
                                                      ""
                                                  ? statement
                                                      .statementPictureURL
                                                      .replaceAll(
                                                          "https%3A%2F%2Fparsefiles.back4app.com%2FFeP6gb7k9R2K9OztjKWA1DgYhubqhW0yJMyrHbxH%2F",
                                                          "")
                                                  : "https://quellenreiter.app/assets/logo-pink.png",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                                      ),
                                    ),
                                    // Display [statement.samplePictureCopyright]
                                    Container(
                                      padding: const EdgeInsets.all(2),
                                      color: const Color.fromARGB(61, 0, 0, 0),
                                      child: SelectableText(
                                        statement.samplePictureCopyright.trim(),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Color(0xFF0999bc),
                                        ),
                                        child: Column(
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
                                            Align(
                                              alignment: Alignment.topLeft,
                                              child: LinkAlert(
                                                  link: statement.statementLink,
                                                  msg:
                                                      "Du verlässt diese Website. Dieser link ist archiviert, kann aber trotzdem unangenehme inhalte aufweisen. Be carful <3."),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(top: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(10)),
                                          color: statement
                                                      .statementCorrectness !=
                                                  CorrectnessCategory.correct
                                              ? const Color(0xFFD55C00)
                                              : const Color(0xFF009E74),
                                        ),
                                        child: Text(
                                          statement.statementCorrectness,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline3,
                                        ),
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
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Author
                                  Row(
                                    children: [
                                      const Icon(Icons.person),
                                      Text(statement.statementAuthor),
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
                                      Text(statement.statementMedia +
                                          ' | ' +
                                          statement.statementMediatype),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Date
                                  Row(
                                    children: [
                                      const Icon(Icons.calendar_month),
                                      SelectableText(statement.dateAsString()),
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
                                      SelectableText(
                                          statement.statementLanguage),
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
    );
  }
}
