import 'package:flutter/material.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:statementmanager/utilities/utilities.dart';
import 'package:statementmanager/widgets/display/display_text_sizable.dart';
import 'package:statementmanager/widgets/main_app_bar.dart';
import '../widgets/display/fact_display_container.dart';

//ignore: must_be_immutable
class DetailScreen extends StatelessWidget {
  DetailScreen(
      {Key? key,
      required this.statement,
      required this.onLogin,
      required this.title,
      required this.isLoggedIn})
      : super(key: key);
  final bool isLoggedIn;
  Statement statement;
  final String title;
  final Function onLogin;

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 1000),
          height: DeviceType.height(context),
          child: ListView(
            shrinkWrap: true,
            children: [
              SizableDisplayText(
                size: 24,
                text: statement.statementText,
                icon: Icons.speaker_notes,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Flexible(
                  child: SizableDisplayText(
                    text: statement.statementAuthor,
                    icon: Icons.person,
                  ),
                ),
                Flexible(
                  child: SizableDisplayText(
                      text: statement.statementMedia, icon: Icons.newspaper),
                )
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: SizableDisplayText(
                          text: statement.statementLanguage,
                          icon: Icons.language),
                    )
                  ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: SizableDisplayText(
                        text: statement.statementDay.toString() +
                            "/" +
                            statement.statementMonth.toString() +
                            "/" +
                            statement.statementYear.toString(),
                        icon: Icons.calendar_month_outlined,
                      ),
                    ),
                    Flexible(
                      child: SizableDisplayText(
                        text: statement.statementLink,
                        icon: Icons.link,
                      ),
                    )
                  ]),
              Flex(
                mainAxisSize: MainAxisSize.min,
                direction: DeviceType.width(context) < 600
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Stack(
                        children: [
                          Image.network(
                            statement.statementPictureURL != ""
                                ? statement.statementPictureURL.replaceAll(
                                    "https%3A%2F%2Fparsefiles.back4app.com%2FFeP6gb7k9R2K9OztjKWA1DgYhubqhW0yJMyrHbxH%2F",
                                    "")
                                : "https://quellenreiter.app/assets/logo-pink.png",
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            color: const Color.fromARGB(61, 0, 0, 0),
                            child: Text(statement.samplePictureCopyright),
                          )
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Column(
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: SizableDisplayText(
                              text: "Kategorie: " + statement.statementCategory,
                            )),
                        Padding(
                            padding: const EdgeInsets.all(5),
                            child: SizableDisplayText(
                              text: "Art des Mediums: " +
                                  statement.statementMediatype,
                            )),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SizableDisplayText(
                            color: statement.statementCorrectness !=
                                    CorrectnessCategory.correct
                                ? const Color.fromARGB(157, 255, 0, 0)
                                : const Color.fromARGB(202, 46, 196, 0),
                            text: "Einordung der Aussage: " +
                                statement.statementCorrectness,
                          ),
                        ),
                        if (statement.statementRectification)
                          const Padding(
                            padding: EdgeInsets.all(5),
                            child: SizableDisplayText(
                              text: "Die Aussage wurde korrigiert.",
                            ),
                          )
                        else
                          const Padding(
                            padding: EdgeInsets.all(5),
                            child: SizableDisplayText(
                              text: "Die Aussage wurde nicht korrigiert.",
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              factContainers.isNotEmpty
                  ? const SizableDisplayText(
                      text: "Faktenchecks und Quellen",
                      size: 24,
                      color: Colors.white12,
                    )
                  : const SizedBox.shrink(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: factContainers,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
