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
    return InkWell(
      onTap: () => onTapped(statement),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2),
                      child: Text(
                        statement.statementText,
                        style: const TextStyle(fontSize: 20.0),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(2),
                      color: statement.statementCorrectness ==
                              CorrectnessCategory.correct
                          ? Colors.green
                          : Colors.red,
                      child: Text("Einordnung: " +
                          statement.statementCorrectness +
                          "."),
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.person),
                    ),
                    Text(statement.statementAuthor),
                  ],
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(5),
                      child: Icon(Icons.newspaper),
                    ),
                    Text(statement.statementMedia),
                  ],
                ),
              ],
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
