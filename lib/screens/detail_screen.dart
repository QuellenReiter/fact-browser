import 'dart:io';
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
    if (widget.statement.statementFactchecks.facts.isEmpty) {
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

  void safeFile(Uint8List? path) {
    setState(() {
      // whaaaat to do here?
      widget.statement.uploadImage = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> factContainers = List.generate(
      numFacts,
      (int i) => FactContainer(controllers: factControllers.controllers[i]),
    );

    // this must be done somewhere alse
    // statements should be updated while edited by the textcontrollers
    // every variable needs to be checked for completenes
    // and then send to database
    void uploadStatement() {
      widget.statement.statementText = statementController.textController.text;
      widget.statement.statementMedia =
          statementController.mediaController.text;
      widget.statement.statementMediatype =
          statementController.mediaTypeController.text;
      widget.statement.statementDate = statementController.dateController.text;
      widget.statement.statementCategory =
          statementController.categoryController.text;
      widget.statement.statementCorrectness =
          statementController.correctnessController.text;
      widget.statement.statementLink = statementController.linkController.text;
      widget.statement.statementLanguage =
          statementController.languageController.text;
      widget.statement.statementAuthor =
          statementController.authorController.text;
      widget.statement.samplePictureCopyright =
          statementController.samplePictureCopyrightController.text;
      // widget.statement.statementPictureURL : already set
      // widget.statement.statementRectification : already set

      // for (int i = 0; i < widget.statement.statementFactchecks.facts.length; i++) {
      //   widget.statement.statementFactchecks.facts[i].factAuthor = factControllers.controllers[i].authorController.text;
      //    und so weiter...
      // }
    }

    void addNewFact() {
      setState(() {
        numFacts += 1;
        widget.statement.statementFactchecks.facts.add(Fact.empty());
        factControllers.controllers.add(FactController(
            widget.statement.statementFactchecks.facts[numFacts - 1]));
      });
    }

    void removeFact() {
      if (numFacts < 1) return;

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
      backgroundColor:
          widget.statement.statementCorrectness != CorrectnessCategory.correct
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
            height: DeviceType.height(context),
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Flexible(
                      child: TextFieldContainer(
                        textController: statementController.textController,
                        label: "Gebe eine Aussage ein.",
                        errorCallback: Utils.checkIfEmpty,
                      ),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: TextFieldContainer(
                              textController:
                                  statementController.authorController,
                              label: "Gebe den Author ein.",
                              errorCallback: Utils.checkIfEmpty),
                        ),
                        Flexible(
                          child: TextFieldContainer(
                              textController:
                                  statementController.mediaController,
                              label: "Gebe das Medium ein.",
                              errorCallback: Utils.checkIfEmpty),
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
                              errorCallback: Utils.checkIfEmpty),
                        ),
                        Flexible(
                          child: TextFieldContainer(
                              textController: statementController
                                  .samplePictureCopyrightController,
                              label: "Gebe ein Copyright für das Foto ein.",
                              errorCallback: Utils.checkIfEmpty),
                        ),
                      ]),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: TextFieldContainer(
                            textController: statementController.dateController,
                            label: "Gebe das Ursprungsdatum ein(dd/mm/yyyy)",
                            errorCallback: Utils.checkIfEmpty,
                            inputFormatter: DateTextFormatter(),
                          ),
                        ),
                        Flexible(
                          child: TextFieldContainer(
                              textController:
                                  statementController.linkController,
                              label:
                                  "Der Link zur Aussage (Wayback machine etc).",
                              errorCallback: Utils.checkIfEmpty),
                        ),
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
                                    child: widget.statement.uploadImage == null
                                        ? Image.network(widget
                                            .statement.statementPictureURL)
                                        : Image.memory(
                                            widget.statement.uploadImage!),
                                  ),
                                ),
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
                                    child: Row(
                                      children: [
                                        const Text("Wähle eine Kategorie?"),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: DropdownButton(
                                            value: widget
                                                .statement.statementCategory,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.statement
                                                        .statementCategory =
                                                    value.toString();
                                              });
                                            },
                                            items: Queries.categoryValues
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
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
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Text("Wähle ein Foto aus."),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: ElevatedButton(
                                              onPressed: () =>
                                                  Utils.pickFile(safeFile),
                                              child: const Text("wählen")),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Text("Wähle einen Medientyp."),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: DropdownButton(
                                            value: widget
                                                .statement.statementMediatype,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.statement
                                                        .statementMediatype =
                                                    value.toString();
                                              });
                                            },
                                            items: Queries.mediatypeValues
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
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
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Text(
                                            "Wie ist die Aussage einzuordnen?"),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: DropdownButton(
                                            value: widget
                                                .statement.statementCorrectness,
                                            onChanged: (value) {
                                              setState(() {
                                                widget.statement
                                                        .statementCorrectness =
                                                    value.toString();
                                              });
                                            },
                                            items: Queries.correctnessValues
                                                .map<DropdownMenuItem<String>>(
                                                    (String value) {
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
                                  flex: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const Text(
                                            "Wurde die Aussage Korrigiert?"),
                                        Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Switch(
                                              value: widget.statement
                                                  .statementRectification,
                                              onChanged: (value) {
                                                setState(() {
                                                  widget.statement
                                                          .statementRectification =
                                                      value;
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
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: factContainers
                          ..add(Row(
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
                              ]))),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton.icon(
                          onPressed: () => uploadStatement,
                          icon: const Icon(Icons.upload_file),
                          label: const Text("Diese Aussage speichern")),
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
