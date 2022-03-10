import 'package:flutter/material.dart';
import 'package:statementmanager/screens/detail_screen.dart';

class StatementCard extends StatelessWidget {
  const StatementCard({Key? key, required this.statement}) : super(key: key);
  final Map<String, dynamic> statement;
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
              statement["text"],
              style: const TextStyle(fontSize: 20.0),
            ),
            Column(
              children: [Text(statement["author"]), Text(statement["date"])],
            ),
          ],
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
      ),
    );
  }
}
