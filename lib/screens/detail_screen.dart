import 'package:flutter/material.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:statementmanager/utilities/utilities.dart';
import '../widgets/fact_display_container.dart';

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
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: GestureDetector(
              child: const Icon(Icons.login),
              onTap: () => onLogin(),
            ),
          )
        ],
        title: Text(
          title,
        ),
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
                      child: Text(statement.statementText),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: Text(statement.statementAuthor),
                        ),
                        Flexible(
                          child: Text(statement.statementMedia),
                        )
                      ]),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: Text(statement.statementLanguage),
                        )
                      ]),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: Text(
                            statement.statementDay.toString() +
                                "." +
                                statement.statementMonth.toString() +
                                "." +
                                statement.statementYear.toString(),
                          ),
                        ),
                        Flexible(
                          child: Text(statement.statementLink),
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
                                Text(statement.samplePictureCopyright),
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
                                      child: Text(
                                        "Kategorie: " +
                                            statement.statementCategory,
                                      )),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: Text(
                                        "Kategorie: " +
                                            statement.statementMediatype,
                                      )),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Text(
                                      "Einordung der Aussage: " +
                                          statement.statementCorrectness,
                                    ),
                                  ),
                                ),
                                if (statement.statementRectification)
                                  const Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
                                        "Die Aussage wurde korrigiert.",
                                      ),
                                    ),
                                  )
                                else
                                  const Flexible(
                                    flex: 2,
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Text(
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
