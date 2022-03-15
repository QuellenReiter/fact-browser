import 'package:flutter/material.dart';
import 'package:statementmanager/models/fact.dart';
import 'package:statementmanager/widgets/text_field_container.dart';

import '../utilities/utilities.dart';

//ignore: must_be_immutable
class FactContainer extends StatefulWidget {
  FactContainer({ Key? key,  this.controllers }) : super(key: key);

  FactController? controllers;
  @override
  State<FactContainer> createState() => _FactContainerState();
}

class _FactContainerState extends State<FactContainer> {
  // late FactControllers factControllers;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    widget.controllers!.dispose();
    super.dispose();
  }

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
            label: "Gebe einen Fakt ein.",
            errorCallback: Utils.checkIfEmpty,
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: TextFieldContainer(
                  textController:
                      widget.controllers!.authorController,
                  label: "Gebe den Author ein.",
                  errorCallback: Utils.checkIfEmpty
                ),
              ),
              Flexible(
                child: TextFieldContainer(
                  textController:
                      widget.controllers!.mediaController,
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
                      widget.controllers!.languageController,
                  label: "Gebe die Originalsprache ein.",
                  errorCallback: Utils.checkIfEmpty
                ),
              ),
              Flexible(
                child: TextFieldContainer(
                  textController:
                      widget.controllers!.dateController,
                  label: "Gebe das Ursprungsdatum ein(dd/mm/yyyy)",
                  errorCallback: Utils.checkIfEmpty,
                  inputFormatter: DateTextFormatter(),
                ),
              ),
            ]),
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: TextFieldContainer(
                  textController:
                      widget.controllers!.linkController,
                  label: "Der Link zur Aussage (Wayback machine etc).",
                  errorCallback: Utils.checkIfEmpty
                ),
              ),
            ]),
          ),
          const Divider(
            height: 20,
            thickness: 4,
          )
        ]
       ),
    );
  }
}