import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart';
import 'package:statementmanager/models/statement.dart';
import 'package:statementmanager/provider/queries.dart';

import '../consonents.dart';

class DatabaseUtils {
  final String langName, saveFormat, objectId;

  DatabaseUtils({this.langName = "", this.saveFormat = "", this.objectId = ""});

  // String delete='''
  // mutation DELETE_LANGUAGES(\$id: ID!){
  //   deleteLanguage(input: {id:\$id}){
  //     language{
  //       name,
  //       id
  //     }
  //   }
  // }
  // ''';

  // String addData='''
  // mutation CREATE_LANGUAGES(\$input: CreateLanguageFieldsInput){
  //   createLanguage(input: {fields: \$input}){
  //     language{
  //       name,
  //       saveFormat
  //     }
  //   }
  // }
  // ''';
  // String update='''
  // mutation UPDATE_LANGUAGES(\$id: ID!,\$input: UpdateLanguageFieldsInput){
  //   updateLanguage(input: {id:\$id, fields:\$input}){
  //     language{
  //       name,
  //       id
  //     }
  //   }
  // }
  // ''';

  Future<QueryResult> sendData(
      Statement statement, BuildContext context) async {
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
      //'X-Parse-REST-API-Key' : kParseRestApiKey,
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
      return uploadResult;
    }

    print("Image uplaoded");

    //update picture url
    statement.statementPictureURL =
        uploadResult.data?["createFile"]["fileInfo"]["url"];

    var queryResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.createStatement(statement)),
      ),
    );
    print(queryResult.toString());
    if (queryResult.hasException) {
      // show some warning
      print(queryResult.exception.toString());
    } else {
      print("Statement added.");
    }
    Navigator.pop(context);
    return queryResult;
  }

  Future<QueryResult> updateData(Statement statement, List<String> oldFactIds,
      BuildContext context) async {
    // Setup Client
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
        print(factResult.toString());
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
      print(factResult.toString());
    }

    var queryResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.updateStatement(statement)),
      ),
    );
    print(queryResult.toString());
    if (queryResult.hasException) {
      // show some warning
      print(queryResult.exception.toString());
    } else {
      print("RESULT:");
      print(queryResult.data.toString());
    }
    Navigator.pop(context);
    return queryResult;
  }

  // Future<QueryResult> deleteData() async {
  //   final variable = {
  //     "id": objectId,
  //   };

  //   final HttpLink httpLink = HttpLink(kUrl, defaultHeaders: {
  //     'X-Parse-Application-Id': kParseApplicationId,
  //     'X-Parse-Client-Key': kParseClientKey,
  //     //'X-Parse-REST-API-Key' : kParseRestApiKey,
  //   });
  //   // create the data provider
  //   GraphQLClient client = GraphQLClient(
  //     cache: GraphQLCache(),
  //     link: httpLink,
  //   );

  //   QueryResult queryResult = await client.query(
  //     QueryOptions(document: gql(delete), variables: variable),
  //   );

  //   return queryResult;
  // }
}
