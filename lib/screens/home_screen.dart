import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/utilities/utilities.dart';
import 'package:statementmanager/widgets/statement_card.dart';

import '../consonents.dart';
import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {Key? key,
      required this.title,
      required this.onSelectStatement,
      required this.onQueryChanged,
      required this.query,
      required this.onLogin,
      required this.isLoggedIn,
      required this.createStatement})
      : super(key: key);

  final ValueChanged<Statement> onSelectStatement;
  final ValueChanged<String> onQueryChanged;
  final Function createStatement;
  final Function onLogin;
  final String title;
  final String? query;
  final bool isLoggedIn;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController searchController;
  late Statements statements;
  @override
  void initState() {
    searchController = widget.query == null
        ? TextEditingController()
        : TextEditingController(text: widget.query);
    searchController.addListener(() {
      widget.onQueryChanged(searchController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-Client-Key': kParseClientKey,
      //'X-Parse-REST-API-Key' : kParseRestApiKey,
    });
    // create the data provider
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );

    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: GestureDetector(
                child: const Icon(Icons.login),
                onTap: () => widget.onLogin(),
              ),
            )
          ],
          title: Text(widget.title),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        floatingActionButton: widget.isLoggedIn
            ? FloatingActionButton(
                child: const Icon(Icons.add),
                onPressed: () => widget.createStatement(),
              )
            : null,
        body: ValueListenableBuilder(
            valueListenable: searchController,
            builder: (context, TextEditingValue value, __) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 1000,
                    ),
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
                                            statement:
                                                statements.statements[index],
                                            onTapped: widget.onSelectStatement,
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
                  ),
                ),
              );
            }),
      ),
    );
  }
}
