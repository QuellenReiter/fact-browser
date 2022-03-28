import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/queries.dart';

import '../consonents.dart';

class DatabaseUtils {
  final safeStorage = const FlutterSecureStorage();

  Future<QueryResult?> sendData(
      Statement statement, Function reloadDetailScreen) async {
    String? token = await safeStorage.read(key: "token");
    if (token == null) {
      return null;
    }
    // prepare the picture
    MultipartFile multipartFile = MultipartFile.fromBytes(
      Queries.statementPicture,
      statement.uploadImage!.toList(),
      filename: '${DateTime.now().second}.jpg',
      contentType: MediaType("image", "jpg"),
    );

    final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-Client-Key': kParseClientKey,
      'X-Parse-Session-Token': token,
    });
    // create the data provider
    GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    print('sendingFile');

    var uploadResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.createFile()),
        variables: {
          "file": multipartFile,
        },
      ),
    );
    print(uploadResult.toString());

    if (uploadResult.hasException) {
      reloadDetailScreen(null, "Upload fehlgeschlagen.");
      return uploadResult;
    }

    print("Image uplaoded");

    //update picture url
    statement.statementPictureURL =
        uploadResult.data?["createFile"]["fileInfo"]["url"];

    var queryResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.createStatement()),
        variables: {
          "input": statement.toMap(),
        },
      ),
    );
    print(queryResult.toString());
    if (queryResult.hasException) {
      // show some warning
      reloadDetailScreen(null, "Upload fehlgeschlagen.");
      return uploadResult;
    } else {
      print("Statement added.");
    }
    reloadDetailScreen(
        Statement.fromMap(queryResult.data?["createStatement"]["statement"]),
        null);
    return queryResult;
  }

  Future<QueryResult?> updateData(Statement statement, List<String> oldFactIds,
      Function reloadDetailScreen) async {
    String? token = await safeStorage.read(key: "token");
    if (token == null) {
      return null;
    }
    // Setup Client
    final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-Client-Key': kParseClientKey,
      'X-Parse-Session-Token': token,
    });
    // create the data provider
    GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    // prepare the picture if updated
    if (statement.uploadImage != null) {
      MultipartFile multipartFile = MultipartFile.fromBytes(
        Queries.statementPicture,
        statement.uploadImage!.toList(),
        filename: '${DateTime.now().second}.jpg',
        contentType: MediaType("image", "jpg"),
      );
      print('sendingFile');

      var uploadResult = await client.mutate(
        MutationOptions(
          document: gql(Queries.createFile()),
          variables: {
            "file": multipartFile,
          },
        ),
      );
      print(uploadResult.toString());

      if (uploadResult.hasException) {
        reloadDetailScreen(null, "Upload fehlgeschlagen.");
        return uploadResult;
      }

      print("Image uploaded");

      //update the pictureURL
      statement.statementPictureURL =
          uploadResult.data?["createFile"]["fileInfo"]["url"];
    }

    // delete all facts:
    for (var fact in statement.statementFactchecks.facts) {
      // only if fact exists and thus has an objectId
      if (fact.objectId != null) {
        var factResult = await client.mutate(
          MutationOptions(
            document: gql(Queries.deleteFact(fact.objectId!)),
          ),
        );
        //remove deleted ID from oldIDs
        oldFactIds.remove(fact.objectId);
        if (factResult.hasException) {
          reloadDetailScreen(null, "Upload fehlgeschlagen.");
          return factResult;
        }
      }
    }
    // and remove all facts, that have been removed
    for (var id in oldFactIds) {
      // only if fact exists and thus has an objectId

      var factResult = await client.mutate(
        MutationOptions(
          document: gql(Queries.deleteFact(id)),
        ),
      );
      if (factResult.hasException) {
        reloadDetailScreen(null, "Upload fehlgeschlagen.");
        return factResult;
      }
    }

    var queryResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.updateStatement()),
        variables: {
          "input": statement.toMap(),
        },
      ),
    );
    print(queryResult.toString());
    if (queryResult.hasException) {
      reloadDetailScreen(null, "Upload fehlgeschlagen.");
      return queryResult;
    } else {
      print("RESULT:");
      print(queryResult.data.toString());
    }
    reloadDetailScreen(
        Statement.fromMap(queryResult.data?["updateStatement"]["statement"]),
        null);
    return queryResult;
  }

  void login(String username, String password, Function loginCallback) async {
    const safeStorage = FlutterSecureStorage();

    final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
      'X-Parse-Application-Id': kParseApplicationId,
      'X-Parse-Client-Key': kParseClientKey,
      //'X-Parse-REST-API-Key' : kParseRestApiKey,
    });
    // create the data provider
    GraphQLClient client = GraphQLClient(
      cache: GraphQLCache(),
      link: httpLink,
    );

    var loginResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.login(username, password)),
      ),
    );
    if (loginResult.hasException) {
      loginCallback(false);
      return;
    }
    //safe token

    safeStorage.write(
        key: "token",
        value: loginResult.data?["logIn"]["viewer"]["sessionToken"]);
    loginCallback(true);
  }

  Future<void> logout() async {
    const safeStorage = FlutterSecureStorage();
    await safeStorage.delete(key: "token");
  }

  Future<bool> checkToken() async {
    const safeStorage = FlutterSecureStorage();
    String? token = await safeStorage.read(key: "token");

    if (token != null) {
      final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
        'X-Parse-Application-Id': kParseApplicationId,
        'X-Parse-Client-Key': kParseClientKey,
        'X-Parse-Session-Token': token,
      });
      // create the data provider
      GraphQLClient client = GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      );

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
