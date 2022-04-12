import 'package:flutter/material.dart';
import 'package:statementmanager/constants/constants.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/utilities/utilities.dart';
import 'package:statementmanager/widgets/editable/date_container.dart';
import 'package:statementmanager/widgets/editable/text_field_container.dart';

//ignore: must_be_immutable
class FactContainer extends StatefulWidget {
  FactContainer({Key? key, required this.removeFact, this.controllers})
      : super(key: key);

  FactController? controllers;
  final Function removeFact;
  @override
  State<FactContainer> createState() => _FactContainerState();
}

class _FactContainerState extends State<FactContainer> {
  // late FactControllers factControllers;
  @override
  void initState() {
    super.initState();
  }

  // @override
  // void dispose() {
  //   widget.controllers!.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TextFieldContainer(
            textController: widget.controllers!.factController,
            label: "Gib einen Fakt ein.",
            errorCallback: Utils.checkIfEmpty,
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: TextFieldContainer(
                  textController: widget.controllers!.authorController,
                  label: "Gib den Author ein.",
                  errorCallback: Utils.checkIfEmpty,
                  autoCompleteList: Suggestions.authorSuggestions,
                ),
              ),
              Flexible(
                child: TextFieldContainer(
                  textController: widget.controllers!.mediaController,
                  label: "Gib das Medium ein.",
                  errorCallback: Utils.checkIfEmpty,
                  autoCompleteList: Suggestions.mediaSuggestions,
                ),
              ),
            ]),
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: TextFieldContainer(
                  textController: widget.controllers!.languageController,
                  label: "Gib die Originalsprache ein.",
                  errorCallback: Utils.checkIfEmpty,
                  autoCompleteList: Suggestions.languageSuggestions,
                ),
              ),
              Flexible(
                child: DateContainer(
                  yearController: widget.controllers!.yearController,
                  monthController: widget.controllers!.monthController,
                  dayController: widget.controllers!.dayController,
                  label: "Gib das datum ein.",
                ),
              ),
            ]),
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: TextFieldContainer(
                    textController: widget.controllers!.linkController,
                    label: "Der originale Link zum Faktencheck.",
                    errorCallback: Utils.checkIfEmpty),
              ),
              Flexible(
                child: TextFieldContainer(
                    textController: widget.controllers!.archivedLinkController,
                    label:
                        "Der archivierte Link zum Faktencheck (Wayback machine etc).",
                    errorCallback: Utils.checkIfEmpty),
              ),
            ]),
          ),
          Flexible(
            child: TextButton.icon(
              onPressed: () {
                widget.removeFact(widget.controllers);
              },
              icon: const Icon(Icons.remove),
              label: const Text("Fakt entfernen"),
            ),
          ),
          const Divider(
            height: 20,
            thickness: 4,
          ),
        ],
      ),
    );
  }
}
