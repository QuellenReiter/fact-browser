


# sendData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[QueryResult](https://pub.dev/documentation/graphql/5.0.1/graphql/QueryResult-class.html)?> sendData
([Statement](../../models_statement/Statement-class.md) statement, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) reloadEditScreen)





<p>Send a newly created <a href="../../models_statement/Statement-class.md">Statement</a> to the Database.</p>



## Implementation

```dart
Future<QueryResult?> sendData(
    Statement statement, Function reloadEditScreen) async {
  // The session token of the user.
  String? token = await safeStorage.read(key: "token");
  // If not logged in, return.
  if (token == null) {
    return null;
  }

  // Link to server.
  final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
    'X-Parse-Application-Id': kParseApplicationId,
    'X-Parse-Client-Key': kParseClientKey,
    'X-Parse-Session-Token': token,
  });

  // Provides data from server and facilitates requests.
  GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  // The Result from the database mutation.
  var queryResult = await client.mutate(
    MutationOptions(
      document: gql(Queries.createStatement()),
      variables: {
        "input": statement.toMap(),
      },
    ),
  );
  // If the result has any exception.
  if (queryResult.hasException) {
    // Show some warning and return.
    reloadEditScreen(null, "Upload fehlgeschlagen.");
    return queryResult;
  }
  // Call the callback to reload the Editscreen.
  reloadEditScreen(
      Statement.fromMap(queryResult.data?["createStatement"]["statement"]),
      null);
  // And return the result.
  return queryResult;
}
```







