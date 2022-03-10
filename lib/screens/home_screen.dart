import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
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
  int _counter = 0;

  String query = '''
  query getSomeStatements{
  statements{
    edges{
      node{
        text,
        author,
        date,
        true,
        medium,
        language,
        statementLink,
        relevance
      }
    }
  }
}
  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Query(
        options: QueryOptions(
          document: gql(query),
        ),
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
            return ListView.builder(
                itemCount: result.data?["statements"]["edges"].length,
                itemBuilder: (BuildContext context, int index) {
                  // return ListTile(
                  //   title: Text(result.data?["statements"]["edges"][index]
                  //       ['node']['text']),
                  //   trailing: Text(result.data?["statements"]["edges"][index]
                  //       ['node']['date']),
                  // );
                  return StatementCard(
                      statement: result.data?["statements"]["edges"][index]
                          ['node']);
                });
          }
        },
      ),
    );
  }
}
