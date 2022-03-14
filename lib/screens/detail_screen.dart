import 'package:flutter/material.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/device_type_provider.dart';
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
                        child: Row(children: [
                          Flexible(
                            child: TextFieldContainer(
                              textController:
                                  statementController.mediaTypeController,
                              label: "Gebe den Aussagentyp ein",
                            ),
                          ),
                          Flexible(
                            child: TextFieldContainer(
                              textController:
                                  statementController.categoryController,
                              label: "Gebe Tags, mit comma getrennt, ein.",
                            ),
                          ),
                        ]),
                      ),
                    ],
                  ),
                ),
                // fact in own screen or in third column
                // Builder(builder: builder)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
