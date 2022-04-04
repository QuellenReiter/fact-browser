import 'package:flutter/material.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/utilities/utilities.dart';

class StatementCard extends StatelessWidget {
  const StatementCard(
      {Key? key, required this.statement, required this.onTapped})
      : super(key: key);
  final Statement statement;
  final ValueChanged<Statement> onTapped;
  @override
  Widget build(BuildContext context) {
    List<Widget> factcheckMediaList = List.generate(
      statement.statementFactchecks.facts.length,
      (int i) => Row(
        children: [
          const Icon(
            Icons.fact_check,
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text(
              statement.statementFactchecks.facts[i].factMedia,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          ),
        ],
      ),
    );
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Material(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: Colors.grey[200],
        child: InkWell(
          hoverColor: Colors.grey[300],
          highlightColor: Colors.grey[400],
          splashColor: Colors.grey[600],
          onTap: () => onTapped(statement),
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    statement.statementText,
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: statement.statementCorrectness ==
                                  CorrectnessCategory.correct
                              ? const Color(0xFF009e73)
                              : const Color(0xFFd55e00),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5),
                          ),
                        ),
                        padding: const EdgeInsets.all(4),
                        child: Text(
                          statement.statementCorrectness,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Text(
                        statement.statementMedia +
                            ', ' +
                            statement.dateAsString(),
                        style: Theme.of(context).textTheme.bodyText2,
                      )
                    ],
                  ),
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: factcheckMediaList,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
