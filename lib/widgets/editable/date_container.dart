import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fact_browser/utilities/utilities.dart';

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
          child: ValueListenableBuilder(
            valueListenable: dayController,
            builder: (context, TextEditingValue value, __) {
              return TextField(
                style: Theme.of(context).textTheme.headline2,
                maxLength: 2,
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
                controller: dayController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: "Tag",
                  border: const OutlineInputBorder(),
                  errorText: Utils.checkIfDay(dayController),
                ),
              );
            },
          ),
        ),
        Flexible(
          child: ValueListenableBuilder(
            valueListenable: monthController,
            builder: (context, TextEditingValue value, __) {
              return TextField(
                style: Theme.of(context).textTheme.headline2,
                maxLength: 2,
                controller: monthController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: "Monat",
                  border: const OutlineInputBorder(),
                  errorText: Utils.checkIfMonth(monthController),
                ),
              );
            },
          ),
        ),
        Flexible(
          child: ValueListenableBuilder(
            valueListenable: yearController,
            builder: (context, TextEditingValue value, __) {
              return TextField(
                style: Theme.of(context).textTheme.headline2,
                maxLength: 4,
                controller: yearController,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  counterText: "",
                  labelText: "Jahr",
                  border: const OutlineInputBorder(),
                  errorText: Utils.checkIfYear(yearController),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }
}
