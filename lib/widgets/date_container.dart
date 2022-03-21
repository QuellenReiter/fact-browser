import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:statementmanager/utilities/utilities.dart';

class DateContainer extends StatelessWidget {
  const DateContainer(
      {Key? key,
      required this.yearController,
      required this.monthController,
      required this.dayController,
      required this.label})
      : super(key: key);

  final TextEditingController yearController;
  final TextEditingController monthController;
  final TextEditingController dayController;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Row(children: [
        Flexible(
          child: TextField(
            maxLength: 2,
            controller: dayController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: "",
              labelText: "Tag",
              border: const OutlineInputBorder(),
              // errorText: Utils.checkIfEmpty(dayController),
            ),
          ),
        ),
        Flexible(
          child: TextField(
            maxLength: 2,
            controller: monthController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: "",
              labelText: "Monat",
              border: const OutlineInputBorder(),
              // errorText: Utils.checkIfEmpty(monthController),
            ),
          ),
        ),
        Flexible(
          child: TextField(
            maxLength: 4,
            controller: yearController,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: "",
              labelText: "Jahr",
              border: const OutlineInputBorder(),
              // errorText: Utils.checkIfEmpty(yearController),
            ),
          ),
        ),
      ]),
    );
  }
}
