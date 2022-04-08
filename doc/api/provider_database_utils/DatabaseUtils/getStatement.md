


# getStatement method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[Statement](../../models_statement/Statement-class.md)?> getStatement
([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? statementID)





<p>Get a single <code>Statement</code> from the Database by <a href="../../models_statement/Statement/objectId.md">Statement.objectId</a>.</p>



## Implementation

```dart
Future<Statement?> getStatement(String? statementID) async {
  final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
    'X-Parse-Application-Id': kParseApplicationId,
    'X-Parse-Client-Key': kParseClientKey,
  });
  // create the data provider
  GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
  var queryResult = await client.query(
    QueryOptions(
      document: gql(Queries.getStatement(statementID)),
    ),
  );
  if (queryResult.hasException) {
    return null;
  }
  return Statement.fromMap(queryResult.data?["statement"]);
}
```







