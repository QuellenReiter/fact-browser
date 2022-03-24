import 'package:flutter/material.dart';
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
      required this.title})
      : super(key: key);

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
      ),
      backgroundColor:
          statement.statementCorrectness != CorrectnessCategory.correct
              ? const Color(0xFFff3a93)
              : const Color(0xFF0999bc),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1000,
            ),
            // this is a problem ? may case these squeezing effects.
            height: DeviceType.height(context) * 2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: SizableDisplayText(
                          size: 40, text: statement.statementText),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: SizableDisplayText(
                              text: statement.statementAuthor),
                        ),
                        Flexible(
                          child: SizableDisplayText(
                              text: statement.statementMedia),
                        )
                      ]),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: SizableDisplayText(
                              text: statement.statementLanguage),
                        )
                      ]),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: SizableDisplayText(
                            text: statement.statementDay.toString() +
                                "." +
                                statement.statementMonth.toString() +
                                "." +
                                statement.statementYear.toString(),
                          ),
                        ),
                        Flexible(
                          child:
                              SizableDisplayText(text: statement.statementLink),
                        )
                      ]),
                    ),
                    Flexible(
                      flex: 5,
                      child: Flex(
                        direction: DeviceType.oneColumn(context)
                            ? Axis.vertical
                            : Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Image.network(
                                        statement.statementPictureURL),
                                  ),
                                ),
                                SizableDisplayText(
                                    text: statement.samplePictureCopyright),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: SizableDisplayText(
                                        text: "Kategorie: " +
                                            statement.statementCategory,
                                      )),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: SizableDisplayText(
                                        text: "Kategorie: " +
                                            statement.statementMediatype,
                                      )),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: SizableDisplayText(
                                      text: "Einordung der Aussage: " +
                                          statement.statementCorrectness,
                                    ),
                                  ),
                                ),
                                if (statement.statementRectification)
                                  const Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: SizableDisplayText(
                                        text: "Die Aussage wurde korrigiert.",
                                      ),
                                    ),
                                  )
                                else
                                  const Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: SizableDisplayText(
                                        text:
                                            "Die Aussage wurde nicht korrigiert.",
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          // fact in own screen or in third column
                          // Builder(builder: builder)
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: factContainers,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
