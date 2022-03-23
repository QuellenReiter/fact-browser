import 'package:flutter/material.dart';
import 'package:statementmanager/models/fact.dart';

//ignore: must_be_immutable
class FactDisplayContainer extends StatelessWidget {
  const FactDisplayContainer({
    Key? key,
    required this.fact,
  }) : super(key: key);

  final Fact fact;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(fact.factText),
          Flexible(
            child: Row(children: [
              Flexible(
                child: Text(fact.factAuthor),
              ),
              Flexible(
                child: Text(fact.factMedia),
              ),
            ]),
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: Text(fact.factLanguage),
              ),
              Flexible(
                child: Text(
                  fact.factDay.toString() +
                      "." +
                      fact.factMonth.toString() +
                      "." +
                      fact.factYear.toString(),
                ),
              ),
            ]),
          ),
          Flexible(
            child: Row(children: [
              Flexible(
                child: Text(fact.factLink),
              ),
            ]),
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
