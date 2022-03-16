import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/utilities/utilities.dart';
import 'package:statementmanager/widgets/statement_card.dart';

import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  late Statements statements;
  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                statement: Statement.empty(),
              ),
            ),
          );
        },
      ),
      body: ValueListenableBuilder(
          valueListenable: searchController,
          builder: (context, TextEditingValue value, __) {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                    labelText: "Search by subject, e.g. Covid",
                    border: const OutlineInputBorder(),
                    errorText: Utils.checkIfEmpty(searchController),
                  ),
                ),
                Builder(
                  builder: (BuildContext context) {
                    if (Utils.checkIfEmpty(searchController) == null) {
                      return Query(
                        options: QueryOptions(
                            document: gql(Queries.searchStatements(
                                searchController.text))),
                        builder: (
                          QueryResult result, {
                          VoidCallback? refetch,
                          FetchMore? fetchMore,
                        }) {
                          if (result.data == null) {
                            return const Center(
                              child: Text(
                                "Loading...",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            );
                          } else {
                            print(result.data.toString());
                            statements = Statements.fromMap(result.data);
                            return Flexible(
                              child: ListView.builder(
                                  itemCount: statements.statements.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return StatementCard(
                                      statement: statements.statements[index],
                                    );
                                  }),
                            );
                          }
                        },
                      );
                    } else {
                      return const Text("");
                    }
                  },
                ),
              ]),
            );
          }),
    );
  }
}
