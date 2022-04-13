import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:statementmanager/constants/constants.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/database_utils.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
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
      required this.title,
      required this.isLoggedIn})
      : super(key: key);

  Statement statement;
  final bool isLoggedIn;
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

  void safeFile(Uint8List img) {
    Navigator.of(context).pop(context);
    setState(() {
      // whaaaat to do here?
      widget.statement.uploadImage = img;
    });
  }

  void reloadAndPopLoading(Statement? _statement, String? _error) {
    setState(() {
      Navigator.of(context).pop(context);
      errorText = _error;
      if (_statement != null) {
        widget.statement = _statement;
      }
    });
  }

  void uploadStatement() async {
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
      Navigator.of(context).pop(context);
      setState(() {
        errorText = "Keines der Felder darf Leer sein.";
      });
      return;
    }
    // push everything to server
    if (widget.statement.objectId == null) {
      // create new statement
      DatabaseUtils db = DatabaseUtils();
      var queryResult =
          await db.sendData(widget.statement, reloadAndPopLoading);
      if (queryResult == null || queryResult.hasException) {
        Navigator.of(context).pop(context);
        setState(() {
          errorText = "Erstellen des Statements fehlgeschlagen!";
        });
        return;
      }
    } else {
      // update existing statement
      DatabaseUtils db = DatabaseUtils();
      var queryResult = await db.updateData(
          widget.statement, factsToBeDeleted, reloadAndPopLoading);
      if (queryResult == null || queryResult.hasException) {
        Navigator.of(context).pop(context);
        setState(() {
          errorText = "Update des Statements fehlgeschlagen!";
        });
        return;
      }
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
        loggedIn: widget.isLoggedIn,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 1000),
          height: DeviceType.height(context),
          child: ListView(shrinkWrap: true, children: [
            errorText == null
                ? const Text("")
                : Container(
                    padding: const EdgeInsets.all(10),
                    color: DesignColors.red,
                    child: Text(
                      errorText!,
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                    ),
                  ),
            TextFieldContainer(
              textController: statementController.textController,
              label: "Gib eine Aussage ein.",
              errorCallback: Utils.checkIfEmpty,
            ),
            Row(children: [
              Flexible(
                child: TextFieldContainer(
                  textController: statementController.authorController,
                  label: "Gib den Author ein.",
                  errorCallback: Utils.checkIfEmpty,
                  autoCompleteList: Suggestions.authorSuggestions,
                ),
              ),
              Flexible(
                child: TextFieldContainer(
                  textController: statementController.mediaController,
                  label: "Gib das Medium ein.",
                  errorCallback: Utils.checkIfEmpty,
                  autoCompleteList: Suggestions.mediaSuggestions,
                ),
              ),
            ]),
            Row(children: [
              Flexible(
                child: TextFieldContainer(
                  textController: statementController.languageController,
                  label: "Gib die Originalsprache ein.",
                  errorCallback: Utils.checkIfEmpty,
                  autoCompleteList: Suggestions.languageSuggestions,
                ),
              ),
            ]),
            Row(children: [
              Flexible(
                child: DateContainer(
                  yearController: statementController.yearController,
                  monthController: statementController.monthController,
                  dayController: statementController.dayController,
                  label: "Gib das Ursprungsdatum ein(dd/mm/yyyy)",
                ),
              ),
              Flexible(
                child: TextFieldContainer(
                    textController: statementController.linkController,
                    label: "Der Link zur Aussage (Wayback machine etc).",
                    errorCallback: Utils.checkIfEmpty),
              ),
            ]),
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
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: widget.statement.uploadImage == null &&
                                  widget.statement.statementPictureURL == null
                              ? Image.asset("assets/logo-pink.png")
                              : widget.statement.uploadImage != null
                                  ? Image.memory(widget.statement.uploadImage!)
                                  : Image.network(widget
                                      .statement.statementPictureURL!
                                      .replaceAll(
                                          "https%3A%2F%2Fparsefiles.back4app.com%2FFeP6gb7k9R2K9OztjKWA1DgYhubqhW0yJMyrHbxH%2F",
                                          "")),
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
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
                                  onChanged: (value) {
                                    setState(() {
                                      widget.statement.statementCategory =
                                          value.toString();
                                    });
                                  },
                                  items: DropdownValues.categoryValues
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
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
                              const Text("Wähle einen Medientyp."),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: DropdownButton(
                                  value: widget.statement.statementMediatype,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.statement.statementMediatype =
                                          value.toString();
                                    });
                                  },
                                  items: DropdownValues.mediatypeValues
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: highlightedDrop
                              ? DesignColors.green
                              : DesignColors.lightGrey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: 100,
                        child: Stack(
                          children: [
                            buildDropZone(context),
                            Center(child: Text(dropMsg)),
                          ],
                        ),
                      ),
                      Flexible(
                        child: TextFieldContainer(
                          textController: statementController
                              .samplePictureCopyrightController,
                          label: "Gib ein Copyright für das Foto ein.",
                          errorCallback: (TextEditingController c) {
                            return null;
                          },
                        ),
                      ),
                      Flexible(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: widget.statement.statementCorrectness !=
                                    CorrectnessCategory.correct
                                ? DesignColors.red
                                : DesignColors.green,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              const Text("Wie ist die Aussage einzuordnen?"),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: DropdownButton(
                                  value: widget.statement.statementCorrectness,
                                  onChanged: (value) {
                                    setState(() {
                                      widget.statement.statementCorrectness =
                                          value.toString();
                                    });
                                  },
                                  items: DropdownValues.correctnessValues
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2,
                                      ),
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
                                child: Switch(
                                    value:
                                        widget.statement.statementRectification,
                                    onChanged: (value) {
                                      setState(() {
                                        widget.statement
                                            .statementRectification = value;
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
          ]),
        ),
      ),
    );
  }

  late DropzoneViewController dropController;
  bool highlightedDrop = false;
  String dropMsg = "Datei hierher ziehen";
  Widget buildDropZone(BuildContext context) => Builder(
        builder: (context) => DropzoneView(
          operation: DragOperation.copy,
          cursor: CursorType.grab,
          onCreated: (ctrl) => dropController = ctrl,
          // onLoaded: () => print('Zone 1 loaded'),
          // onError: (ev) => print('Zone 1 error: $ev'),
          onHover: () {
            setState(() => highlightedDrop = true);
            // print('Zone 1 hovered');
          },
          onLeave: () {
            setState(() => highlightedDrop = false);
            // print('Zone 1 left');
          },
          onDrop: (ev) async {
            setState(() {
              dropMsg = '${ev.name} dropped';
              highlightedDrop = false;
            });
            showModalBottomSheet<void>(
                context: context,
                isDismissible: false,
                builder: (BuildContext context) {
                  return Container(
                    height: DeviceType.height(context) / 2,
                    child: const Center(
                      child: Text("Bild wird geladen."),
                    ),
                  );
                });
            final bytes = await dropController.getFileData(ev);
            Utils.compressImage(bytes, safeFile);
          },
        ),
      );
}
