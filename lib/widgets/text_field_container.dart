import 'package:flutter/material.dart';
import '../utilities/utilities.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(
      {Key? key, required this.textController, required this.label})
      : super(key: key);

  final TextEditingController textController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: textController,
      builder: (context, TextEditingValue value, __) {
        return Container(
          padding: const EdgeInsets.all(5),
          child: TextField(
            controller: textController,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
              errorText: Utils.checkIfEmpty(textController),
            ),
          ),
        );
      },
    );
  }
}
