import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/utilities/utilities.dart';

import '../widgets/fact_container.dart';
import '../widgets/text_field_container.dart';

//ignore: must_be_immutable
class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.statement}) : super(key: key);

  Statement statement;
  
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late StatementController statementController;
  late FactControllers factControllers;
  late int numFacts;

  @override
  void initState() {
    statementController = StatementController(widget.statement);

    // if no facts, add an empty one.
    if(widget.statement.statementFactchecks.facts.isEmpty){
      widget.statement.statementFactchecks.facts.add(Fact.empty());
    }
    factControllers = FactControllers(widget.statement.statementFactchecks);
    numFacts = widget.statement.statementFactchecks.facts.length;
    super.initState();
  }

  @override
  void dispose() {
    statementController.dispose();
    super.dispose();
  }

  void safeFile(Uint8List? path){
    setState(() {
      widget.statement.statementPictureURL = path.toString();
    });
  }


  @override
  Widget build(BuildContext context) {

    List<Widget> factContainers =
        List.generate(numFacts, (int i) => FactContainer(
                                                  controllers: factControllers.controllers[i]
                                                  ),
                                                );


    void addNewFact(){
      setState(() {
      numFacts += 1;
      widget.statement.statementFactchecks.facts.add(Fact.empty());
      factControllers.controllers.add(FactController(Fact.empty()));
      });
    }
    void removeFact(){
      if(numFacts<1) return;

      setState(() {
      numFacts -= 1;
      widget.statement.statementFactchecks.facts.removeLast();
      factControllers.controllers.removeLast();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.statement.statementText,
        ),
      ),
      body: Container(
        height: DeviceType.height(context),
        color: widget.statement.statementCorrectness != CorrectnessCategory.correct
            ? const Color(0xFFff3a93)
            : const Color(0xFF0999bc),
        child: Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
              Flex(
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
                        TextFieldContainer(
                          textController: statementController.textController,
                          label: "Gebe eine Aussage ein.",
                          errorCallback: Utils.checkIfEmpty,
                        ),
                        Flexible(
                          child: Row(children: [
                            Flexible(
                              child: TextFieldContainer(
                                textController:
                                    statementController.authorController,
                                label: "Gebe den Author ein.",
                                errorCallback: Utils.checkIfEmpty
                              ),
                            ),
                            Flexible(
                              child: TextFieldContainer(
                                textController:
                                    statementController.mediaController,
                                label: "Gebe das Medium ein.",
                                errorCallback: Utils.checkIfEmpty
                              ),
                            ),
                          ]),
                        ),
                        Flexible(
                          child: Row(children: [
                            Flexible(
                              child: TextFieldContainer(
                                textController:
                                    statementController.languageController,
                                label: "Gebe die Originalsprache ein.",
                                errorCallback: Utils.checkIfEmpty
                              ),
                            ),
                            Flexible(
                              child: TextFieldContainer(
                                textController:
                                    statementController.samplePictureCopyrightController,
                                label: "Gebe ein Copyright für das Foto ein.",
                                errorCallback: Utils.checkIfEmpty
                              ),
                            ),
                          ]),
                        ),
                        Flexible(
                          child: Row(children: [
                            Flexible(
                              child: TextFieldContainer(
                                textController:
                                    statementController.dateController,
                                label: "Gebe das Ursprungsdatum ein(dd/mm/yyyy)",
                                errorCallback: Utils.checkIfEmpty,
                                inputFormatter: DateTextFormatter(),
                              ),
                            ),
                            Flexible(
                              child: TextFieldContainer(
                                textController:
                                    statementController.linkController,
                                label: "Der Link zur Aussage (Wayback machine etc).",
                                errorCallback: Utils.checkIfEmpty
                              ),
                            ),
                          ]),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                const Text("Wähle eine Kategorie?"),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: DropdownButton(
                                    value: widget.statement.statementCategory, 
                                    onChanged: (value){
                                    setState(() {
                                      widget.statement.statementCategory = value.toString();
                                    });
                                    },
                                    items: Queries.categoryValues
                                    .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                const Text("Wähle ein Foto aus."),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: ElevatedButton(
                                    onPressed: () => Utils.pickFile(safeFile),
                                    child: const Text("wählen")),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                const Text("Wähle einen Medientyp."),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: DropdownButton(
                                    value: widget.statement.statementMediatype, 
                                    onChanged: (value){
                                    setState(() {
                                      widget.statement.statementMediatype = value.toString();
                                    });
                                    },
                                    items: Queries.mediatypeValues
                                    .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                const Text("Wie ist die Aussage einzuordnen?"),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: DropdownButton(
                                    value: widget.statement.statementCorrectness,
                                    onChanged: (value){
                                    setState(() {
                                      widget.statement.statementCorrectness = value.toString();
                                    });
                                    },
                                    items: Queries.correctnessValues
                                    .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: Row(
                              children: [
                                const Text("Wurde die Aussage Korrigiert?"),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Switch(value: widget.statement.statementRectification, onChanged: (value){
                                    setState(() {
                                      widget.statement.statementRectification = value;
                                    });
                                  }),
                                )
                              ],
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: factContainers..add(
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: addNewFact,
                        icon: const Icon(Icons.add),
                        label: const Text("Fakt"),
                      ),
                      TextButton.icon(
                        onPressed: removeFact,
                        icon: const Icon(Icons.remove),
                        label: const Text("Fakt"),
                      ),
                    ]
                  )
                )
              ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: ElevatedButton.icon(
                    onPressed: () => print("hello"),
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Diese Aussage speichern")),
                ),
              ]
            ),
          ),
        ),
      ),
    );
  }
}
