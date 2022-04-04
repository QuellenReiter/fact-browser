import 'package:flutter/material.dart';

class EditableField extends StatefulWidget {
  const EditableField({Key? key, required this.text, required this.fieldName})
      : super(key: key);
  final String text;
  final String fieldName;
  @override
  State<EditableField> createState() => _EditableFieldState();
}

class _EditableFieldState extends State<EditableField> {
  late TextEditingController inputController;

  @override
  void initState() {
    inputController = TextEditingController(text: widget.text);
    super.initState();
  }

  @override
  void dispose() {
    inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: ValueListenableBuilder(
          valueListenable: inputController,
          builder: (context, TextEditingValue value, __) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width > 700
                      ? MediaQuery.of(context).size.width * 0.3
                      : MediaQuery.of(context).size.width * 0.6,
                  height: 100,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.fieldName,
                          style: Theme.of(context).textTheme.headline2,
                          textAlign: TextAlign.left,
                        ),
                        TextField(
                          style: Theme.of(context).textTheme.headline2,
                          decoration: InputDecoration(
                            errorText: _errorText,
                          ),
                          controller: inputController,
                        )
                      ]),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > 700
                      ? MediaQuery.of(context).size.width * 0.1
                      : MediaQuery.of(context).size.width * 0.3,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Save"),
                  ),
                ),
              ],
            );
          }),
    );
  }

  String? get _errorText {
    final text = inputController.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    if (text == widget.text) {
      return "Nothing changed";
    }
    // return null if the text is valid
    return null;
  }
}
