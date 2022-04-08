


# updateData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[QueryResult](https://pub.dev/documentation/graphql/5.0.1/graphql/QueryResult-class.html)?> updateData
([Statement](../../models_statement/Statement-class.md) statement, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> oldFactIds, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) reloadEditScreen)





<p>Update a <a href="../../models_statement/Statement-class.md">Statement</a> to from the Database.</p>



## Implementation

```dart
Future<QueryResult?> updateData(Statement statement, List<String> oldFactIds,
    Function reloadEditScreen) async {
  // The session token of the user.
  String? token = await safeStorage.read(key: "token");
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

  // TODO: Handle facts differently..
  // delete all facts:
  for (var fact in statement.statementFactchecks.facts) {
    // Only if fact exists and thus has an objectId
    if (fact.objectId != null) {
      var factResult = await client.mutate(
        MutationOptions(
          document: gql(Queries.deleteFact(fact.objectId!)),
        ),
      );
      // Remove deleted ID from oldIDs
      oldFactIds.remove(fact.objectId);
      if (factResult.hasException) {
        reloadEditScreen(null, "Upload fehlgeschlagen.");
        return factResult;
      }
    }
  }
  // And remove all facts, that have been removed.
  for (var id in oldFactIds) {
    // Only if fact exists and thus has an objectId.

    var factResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.deleteFact(id)),
      ),
    );
    if (factResult.hasException) {
      reloadEditScreen(null, "Upload fehlgeschlagen.");
      return factResult;
    }
  }

  // The Result from the database mutation.
  var queryResult = await client.mutate(
    MutationOptions(
      document: gql(Queries.updateStatement()),
      variables: {
        "input": statement.toMap(),
      },
    ),
  );
  // If result has any exception.
  if (queryResult.hasException) {
    // Show error message on [EditScreen].
    reloadEditScreen(null, "Upload fehlgeschlagen.");
    return queryResult;
  }
  // Reload the edit Screen with the database response.
  reloadEditScreen(
      Statement.fromMap(queryResult.data?["updateStatement"]["statement"]),
      null);
  // Return query result.
  return queryResult;
}
```







