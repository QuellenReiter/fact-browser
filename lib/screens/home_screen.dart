import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/widgets/main_app_bar.dart';
import 'package:statementmanager/widgets/statement_card.dart';

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
      required this.createStatement,
      required this.statements})
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

  /// Statements downloaded from the Database.
  final Statements? statements;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

/// State of the [HomeScreen].
class _HomeScreenState extends State<HomeScreen> {
  /// Stores the query.
  late TextEditingController searchController;

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

    if (widget.statements == null) {
      widget.onQueryChanged("");
    }
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
    // Return the search page widget hierarchy.
    return Scaffold(
      appBar: MainAppBar(
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            constraints: const BoxConstraints(
              // Max width of the search results.
              maxWidth: 1000,
            ),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      constraints: const BoxConstraints(maxWidth: 1000),
                      child: TextField(
                        controller: searchController,
                        style: Theme.of(context).textTheme.headline2,
                        decoration: const InputDecoration(
                          hintText: "Suche nach Themen, z.B. Corona",
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.transparent,
                          contentPadding: EdgeInsets.all(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              widget.statements != null
                  ? Flexible(
                      child: ScrollConfiguration(
                        behavior: ScrollConfiguration.of(context)
                            .copyWith(scrollbars: false),
                        child: AnimationLimiter(
                          child: ListView.builder(
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount: widget.statements!.statements.length,
                            itemBuilder: (BuildContext context, int index) {
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 400),
                                child: SlideAnimation(
                                  horizontalOffset: 30,
                                  child: FadeInAnimation(
                                    child: StatementCard(
                                      statement:
                                          widget.statements!.statements[index],
                                      onTapped: widget.onSelectStatement,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Inhalte laden...",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
            ]),
          ),
        ),
      ),
    );
  }
}
