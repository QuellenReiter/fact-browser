import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/queries.dart';
import '../consonents.dart';

/// This class facilitates the connection to the database and manages its
/// responses.
class DatabaseUtils {
  /// Object to access [FlutterSecureStorage].
  final safeStorage = const FlutterSecureStorage();

  /// Send a newly created [Statement] to the Database.
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

  /// Update a [Statement] to from the Database.
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

  /// Login a user.
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

  /// Logsout a user by deleting the session token.
  Future<void> logout() async {
    const safeStorage = FlutterSecureStorage();
    await safeStorage.delete(key: "token");
  }

  /// Checks if token is valid.
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

  /// Get a single [Statement] from the Database by [Statement.objectId].
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
}
