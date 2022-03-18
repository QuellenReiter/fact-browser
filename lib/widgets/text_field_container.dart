import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utilities/utilities.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(
      {Key? key,
      required this.textController,
      required this.label,
      required this.errorCallback,
      this.inputFormatter})
      : super(key: key);

  final TextEditingController textController;
  final String label;
  final Function errorCallback;
  final TextInputFormatter? inputFormatter;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: textController,
      builder: (context, TextEditingValue value, __) {
        if (inputFormatter == null) {
          return Container(
            padding: const EdgeInsets.all(5),
            child: TextField(
              maxLines: null,
              controller: textController,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                errorText: errorCallback(textController),
              ),
            ),
          );
        } else {
          return Container(
            padding: const EdgeInsets.all(5),
            child: TextField(
              maxLines: null,
              controller: textController,
              inputFormatters: [inputFormatter!],
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                errorText: errorCallback(textController),
              ),
            ),
          );
        }
      },
    );
  }
}
