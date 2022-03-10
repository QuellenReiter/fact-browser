import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/widgets/statement_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;

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
      body: ValueListenableBuilder(
          valueListenable: searchController,
          builder: (context, TextEditingValue value, __) {
            return Column(children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  labelText: "Search by subject, e.g. Covid",
                  errorText: _checkSearch,
                ),
              ),
              Builder(
                builder: (BuildContext context) {
                  if (_checkSearch == null) {
                    return Query(
                      options: QueryOptions(
                          document: gql(
                              Queries.searchStatements(searchController.text))),
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
                          return Expanded(
                            child: ListView.builder(
                                itemCount:
                                    result.data?["statements"]["edges"].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return StatementCard(
                                      statement: result.data?["statements"]
                                          ["edges"][index]['node']);
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
            ]);
          }),
    );
  }

  String? get _checkSearch {
    final text = searchController.text;
    if (text.isEmpty) {
      return 'Can\'t be empty';
    }
    // return null if the text is valid
    return null;
  }
}
