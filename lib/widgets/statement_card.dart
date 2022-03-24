import 'package:flutter/material.dart';
import 'package:statementmanager/models/statement.dart';

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
              child: Text(
                statement.statementText,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            Column(
              children: [
                Text(statement.statementAuthor),
                Text(statement.statementMedia)
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
