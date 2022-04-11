import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldContainer extends StatelessWidget {
  const TextFieldContainer(
      {Key? key,
      required this.textController,
      required this.label,
      required this.errorCallback,
      this.inputFormatter,
      this.autoCompleteList,
      this.color = Colors.transparent})
      : super(key: key);

  final TextEditingController textController;
  final String label;
  final Function errorCallback;
  final TextInputFormatter? inputFormatter;
  final List<String>? autoCompleteList;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: textController,
      builder: (context, TextEditingValue value, __) {
        if (autoCompleteList != null) {
          return Container(
            color: color,
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SelectableText(
                      label,
                      style: Theme.of(context).textTheme.headline2,
                    )),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.all(5),
                    child: Autocomplete(
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController fieldTextEditingController,
                          FocusNode fieldFocusNode,
                          VoidCallback onFieldSubmitted) {
                        return TextField(
                          controller: fieldTextEditingController,
                          focusNode: fieldFocusNode,
                          style: Theme.of(context).textTheme.headline2,
                        );
                      },
                      optionsBuilder: (TextEditingValue val) {
                        textController.text = val.text;
                        if (val.text == "") {
                          return const Iterable<String>.empty();
                        }
                        return autoCompleteList!.where((String option) {
                          return option
                              .toLowerCase()
                              .startsWith(val.text.toLowerCase());
                        });
                      },
                      onSelected: (String selection) {
                        textController.text = selection;
                      },
                      initialValue: textController.value,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else if (inputFormatter == null) {
          return Container(
            color: color,
            padding: const EdgeInsets.all(5),
            child: TextField(
              style: Theme.of(context).textTheme.headline2,
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
            color: color,
            padding: const EdgeInsets.all(5),
            child: TextField(
              style: Theme.of(context).textTheme.headline2,
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
