


# login method




    *[<Null safety>](https://dart.dev/null-safety)*




void login
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) username, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) password, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) loginCallback)





<p>Login a user.</p>



## Implementation

```dart
void login(String username, String password, Function loginCallback) async {
  // Link to server.
  final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
    'X-Parse-Application-Id': kParseApplicationId,
    'X-Parse-Client-Key': kParseClientKey,
    //'X-Parse-REST-API-Key' : kParseRestApiKey,
  });

  // Provides data from server and facilitates requests.
  GraphQLClient client = GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );

  // The result returned from the query.
  var loginResult = await client.mutate(
    MutationOptions(
      document: gql(Queries.login(username, password)),
    ),
  );
  // If login result has any exceptions.
  if (loginResult.hasException) {
    loginCallback(false, "Login fehlgeschlagen.");
    return;
  }
  // Safe the new token.
  safeStorage.write(
      key: "token",
      value: loginResult.data?["logIn"]["viewer"]["sessionToken"]);
  loginCallback(true, null);
}
```







