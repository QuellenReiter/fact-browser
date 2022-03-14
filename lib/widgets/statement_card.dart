import 'package:flutter/material.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/screens/detail_screen.dart';

class StatementCard extends StatelessWidget {
  const StatementCard({Key? key, required this.statement}) : super(key: key);
  final Statement statement;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              statement: statement,
            ),
          ),
        );
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              statement.statementText,
              style: const TextStyle(fontSize: 20.0),
            ),
            Column(
              children: [Text(statement.statementAuthor), Text(statement.statementMedia)],
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
