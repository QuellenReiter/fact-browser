import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:statementmanager/widgets/statement_card.dart';

import '../widgets/editable_field.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({Key? key, required this.statement}) : super(key: key);

  final Map<String, dynamic> statement;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.statement['text'],
        ),
      ),
      body: GridView.count(
        childAspectRatio: 2,
        crossAxisCount: MediaQuery.of(context).size.width > 700 ? 2 : 1,
        children: List<Widget>.generate(widget.statement.length, (int i) {
          return Builder(builder: (BuildContext context) {
            return EditableField(
              text: widget.statement.values.elementAt(i),
              fieldName: widget.statement.keys.elementAt(i),
            );
          });
        }),
      ),
      //     [
      //   EditableField(
      //       text: widget.statement['author'], fieldName: 'author'),
      //   EditableField(text: widget.statement['date'], fieldName: "date"),
      // ],
    );
  }
}
