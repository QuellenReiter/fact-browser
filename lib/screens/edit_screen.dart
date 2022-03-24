import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/database_utils.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/utilities/utilities.dart';
import 'package:statementmanager/widgets/editable/date_container.dart';
import 'package:statementmanager/widgets/editable/fact_container.dart';
import 'package:statementmanager/widgets/editable/text_field_container.dart';
import 'package:statementmanager/widgets/main_app_bar.dart';

//ignore: must_be_immutable
class EditScreen extends StatefulWidget {
  EditScreen(
      {Key? key,
      required this.statement,
      required this.onLogin,
      required this.title})
      : super(key: key);

  Statement statement;
  final String title;
  final Function onLogin;
  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late StatementController statementController;
  late FactControllers factControllers;
  late int numFacts;
  String? errorText;
  List<String> factsToBeDeleted = [];

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

  void safeFile(Uint8List? img) {
    setState(() {
      // whaaaat to do here?
      widget.statement.uploadImage = img;
    });
  }

  void reloadAndPopLoading(Statement? _statement, String? _error) {
    setState(() {
      Navigator.pop(context);
      errorText = _error;
      if (_statement != null) {
        widget.statement = _statement;
      }
    });
  }

  void uploadStatement() {
    // show loading indicator
    showModalBottomSheet<void>(
        context: context,
        isDismissible: false,
        builder: (BuildContext context) {
          return Container(
            height: DeviceType.height(context) / 2,
            child: const Center(
              child: CircularProgressIndicator(
                semanticsLabel: "loading",
              ),
            ),
          );
        });
    //check if all fields are non zero
    if (!widget.statement.isComplete()) {
      Navigator.pop(context);
      setState(() {
        errorText = "Keines der Felder darf Leer sein.";
      });
      return;
    }
    // push everything to server
    if (widget.statement.objectId == null) {
      // create new statement
      DatabaseUtils db = DatabaseUtils();
      db.sendData(widget.statement, reloadAndPopLoading);
    } else {
      // update existing statement
      DatabaseUtils db = DatabaseUtils();
      db.updateData(widget.statement, factsToBeDeleted, reloadAndPopLoading);
    }
  }

  void addNewFact() {
    setState(() {
      numFacts += 1;
      widget.statement.statementFactchecks.facts.add(Fact.empty());
      factControllers.controllers.add(FactController(
          widget.statement.statementFactchecks.facts[numFacts - 1]));
    });
  }

  void removeFact(FactController factController) {
    if (numFacts < 1) return;
    int factIndex = factControllers.controllers.indexOf(factController);
    Fact fact = widget.statement.statementFactchecks.facts.elementAt(factIndex);

    setState(() {
      numFacts -= 1;
      if (fact.objectId != null) {
        //safe id to delete this fact later on
        factsToBeDeleted.add(fact.objectId!);
      }
      widget.statement.statementFactchecks.facts.removeAt(factIndex);
      factControllers.controllers.removeAt(factIndex);
      // remove controller and fact from lists.
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> factContainers = List.generate(
      numFacts,
      (int i) => FactContainer(
        controllers: factControllers.controllers[i],
        removeFact: removeFact,
      ),
    );

    return Scaffold(
      appBar: MainAppBar(
        title: widget.title,
        onLogin: widget.onLogin,
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
            height: DeviceType.height(context) * 2,
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    errorText == null ? const Text("") : Text(errorText!),
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
                      ]),
                    ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          child: DateContainer(
                            yearController: statementController.yearController,
                            monthController:
                                statementController.monthController,
                            dayController: statementController.dayController,
                            label: "Gebe das Ursprungsdatum ein(dd/mm/yyyy)",
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
                                  child: TextFieldContainer(
                                    textController: statementController
                                        .samplePictureCopyrightController,
                                    label:
                                        "Gebe ein Copyright für das Foto ein.",
                                    errorCallback: (TextEditingController c) {
                                      return null;
                                    },
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
                          ..add(ElevatedButton.icon(
                            onPressed: addNewFact,
                            icon: const Icon(Icons.add),
                            label: const Text("Fakt"),
                          ))),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: ElevatedButton.icon(
                          onPressed: () => uploadStatement(),
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
