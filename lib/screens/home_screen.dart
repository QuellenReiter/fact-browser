import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/queries.dart';
import 'package:statementmanager/utilities/utilities.dart';
import 'package:statementmanager/widgets/main_app_bar.dart';
import 'package:statementmanager/widgets/statement_card.dart';

import '../consonents.dart';

/// The Homescreen page with a searchbar.
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

  /// Stores if a statement is selected.
  final ValueChanged<Statement> onSelectStatement;

  /// Listens if the [query] changed
  final ValueChanged<String> onQueryChanged;

  /// Callbackfunction that creates an empty statement.
  final Function createStatement;

  /// Callbackfunction called after login is requested.
  final Function onLogin;

  /// title of the page, currently not displayed in the appBar.
  final String title;

  /// The search term inputted by the user.
  final String? query;

  /// Stores if user is logged in.
  final bool isLoggedIn;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// State of the [HomeScreen].
class _HomeScreenState extends State<HomeScreen> {
  /// Stores the query.
  late TextEditingController searchController;

  /// Stores statements received from server after search.
  late Statements statements;

  /// Initialize [searchController] to query value, if it exists. If not,
  /// inittialize with default constructor.
  /// Add listener [widget.onQueryChanged]
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

  /// Dispose [searchController]
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Link to server.
    final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-Client-Key': kParseClientKey,
      //'X-Parse-REST-API-Key' : kParseRestApiKey,
    });

    // Provides data from server and facilitates requests.
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      ),
    );
    // Return the search page widget hierarchy.
    return GraphQLProvider(
      client: client,
      child: Scaffold(
        appBar: MainAppBar(
          searchController: searchController,
          title: "Suche",
          onLogin: widget.onLogin,
          loggedIn: widget.isLoggedIn,
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  constraints: const BoxConstraints(
                    // Max width of the search results.
                    maxWidth: 1000,
                  ),
                  child: Column(
                    children: [
                      Builder(
                        builder: (BuildContext context) {
                          // if (1 == 1) {
                          return Query(
                            options: QueryOptions(
                              document: searchController.text.isEmpty
                                  ? gql(
                                      Queries.getnNewestStatements(8),
                                    )
                                  : gql(
                                      Queries.searchStatements(
                                          searchController.text),
                                    ),
                            ),
                            builder: (
                              QueryResult result, {
                              VoidCallback? refetch,
                              FetchMore? fetchMore,
                            }) {
                              // Show loading while requesting data.
                              if (result.data == null) {
                                return const Center(
                                  child: SelectableText(
                                    "Loading...",
                                    style: TextStyle(fontSize: 20.0),
                                  ),
                                );
                              } else {
                                statements = Statements.fromMap(result.data);
                                // Build search results.
                                return Flexible(
                                  child: ScrollConfiguration(
                                    behavior: ScrollConfiguration.of(context)
                                        .copyWith(scrollbars: false),
                                    child: ListView.builder(
                                      itemCount: statements.statements.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return StatementCard(
                                          statement:
                                              statements.statements[index],
                                          onTapped: widget.onSelectStatement,
                                        );
                                      },
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                          // } else {
                          //   return const SelectableText("");
                          // }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
