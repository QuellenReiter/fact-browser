import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:statementmanager/consonents.dart';
import 'package:statementmanager/screens/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // link to the API

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

    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        textTheme: const TextTheme(
          bodyText2: TextStyle(
              // default all text widget
              color: Color(0xFFF5DE5B),
              fontSize: 16.0,
              fontFamily: 'Iranian'),
        ),
        // fill back inside all TextFormField
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
        ),
      ),
      home: GraphQLProvider(
        child: const HomeScreen(
          title: "Home",
        ),
        client: client,
      ),
    );
  }
}
