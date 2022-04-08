


# checkToken method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)> checkToken
()





<p>Checks if token is valid.</p>



## Implementation

```dart
Future<bool> checkToken() async {
  // The session token.
  String? token = await safeStorage.read(key: "token");
  // If token is not null, check if it is valid.
  if (token != null) {
    // Link to the database.
    final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-Client-Key': kParseClientKey,
      'X-Parse-Session-Token': token,
    });

    // The client that provides the connection.
    GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    // The query result.
    var queryResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.getCurrentUser()),
      ),
    );
    if (queryResult.hasException) {
      return false;
    } else {
      return true;
    }
  }
  // no token, return false
  return false;
}
```







