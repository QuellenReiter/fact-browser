import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/utilities/utilities.dart';

import '../widgets/text_field_container.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.statement}) : super(key: key);

  final Statement statement;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late StatementController statementController;

  @override
  void initState() {
    statementController = StatementController(widget.statement);
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.statement.statementText,
        ),
      ),
      body: Container(
        height: DeviceType.height(context),
        color: widget.statement.statementCorrectness == CorrectnessCategory.correct
            ? const Color(0xFFff3a93)
            : const Color(0xFF0999bc),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Flexible(
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
                          ),
                          Flexible(
                            child: Row(children: [
                              Flexible(
                                child: TextFieldContainer(
                                  textController:
                                      statementController.authorController,
                                  label: "Gebe den Author ein.",
                                ),
                              ),
                              Flexible(
                                child: TextFieldContainer(
                                  textController:
                                      statementController.mediaController,
                                  label: "Gebe das Medium ein.",
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
                                ),
                              ),
                              Flexible(
                                child: TextFieldContainer(
                                  textController:
                                      statementController.mediaTypeController,
                                  label: "Gebe ein Copyright für das Foto ein.",
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
                                ),
                              ),
                              Flexible(
                                child: TextFieldContainer(
                                  textController:
                                      statementController.linkController,
                                  label: "Der Link zur Aussage (Wayback machine etc).",
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
                                  DropdownButton(
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
                                  ElevatedButton(
                                    onPressed: () => Utils.pickFile(safeFile),
                                    child: const Text("wählen"))
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
                                  DropdownButton(
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
                                  DropdownButton(
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
                                  Switch(value: widget.statement.statementRectification, onChanged: (value){
                                    setState(() {
                                      widget.statement.statementRectification = value;
                                    });
                                  })
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
                Flexible(
                  child: 
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("hier kommt der Fact input stuff hin."),
                      Text("hier kommt der Fact input stuff hin."),
                      Text("hier kommt der Fact input stuff hin."),
                      Text("hier kommt der Fact input stuff hin.")
                    ],
                  ),
                  ),
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }
}
