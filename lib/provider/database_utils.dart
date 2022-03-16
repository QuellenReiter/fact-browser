import 'dart:html';
import 'dart:io';

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

  Future<QueryResult> sendData(Statement statement) async {
    // prepare the picture
    MultipartFile multipartFile = MultipartFile.fromBytes(
      Queries.statementPicture,
      statement.uploadImage!.toList(),
      filename: "test.jpg",
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

    String fileName;
    String fileUrl;

    var uploadResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.createFile()),
        variables: {
          "file": multipartFile,
        },
      ),
    );

    fileName = uploadResult.data?["fileInfo"]["name"];
    fileUrl = uploadResult.data?["fileInfo"]["url"];
    if (uploadResult.hasException) {
      print("Upload exception: ");
      print(uploadResult.exception.toString());
    } else {
      print(fileUrl);
    }

    var queryResult = await client.mutate(
      MutationOptions(
        document: gql(Queries.createStatement(statement, fileName, fileUrl)),
      ),
    );
    if (queryResult.hasException) {
      // show some warning
      print(queryResult.exception.toString());
    } else {
      print("RESULT:");
      print(queryResult.data.toString());
    }
    return queryResult;
  }

  // Future<QueryResult> updateData() async {
  //   final variable = {
  //     "id": objectId,
  //     "input": {"name": langName}
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
  //     QueryOptions(document: gql(update), variables: variable),
  //   );
  //   return queryResult;
  // }

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
