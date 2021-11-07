import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:readily/folder/class_model.dart';
import 'package:readily/folder/user_model.dart';

class BackendRequest {
  static const _baseUrl = "http://localhost:3000";
  final http.Client client;
  final Map<String, String> header;

  BackendRequest()
      : client = http.Client(),
        header = {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
          "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
          "Access-Control-Allow-Headers": "Content-Type, Authorization"
        };

  Future<bool> connectToBackend() async {
    var result = (await client.post(Uri.parse(_baseUrl))).body;
    if (result != null) return true;
    return false;
  }

  Future<UserModel?> loginUser(String email, String password) async {
    Map<String, String> body = {"email": email, "password": password};

    return client.post(Uri.parse(_baseUrl + "/signin"), body: body).then((value) {
      var body = jsonDecode(value.body);

      if (body == null) {
        return null;
      } else {
        return UserModel.fromJson(body);
      }
    }).catchError((error, stack) {
      print("Error signing in: $error $stack");
      return null;
    });
  }

  Future<UserModel?> signUpUser(UserModel user) async {
    return client.post(Uri.parse(_baseUrl + "/signup"), body: jsonEncode(user.toJson()), headers: header).then((value) {
      print("Body is  ${value.body}");
      var body = jsonDecode(value.body);

      if (body == null) {
        return null;
      } else {
        return user;
      }
    }).catchError((error, stack) {
      print("Error signing in: $error $stack");
      return null;
    });
  }

  createClass() async {}

  Future<List<ClassModel>?> getClasses(List<String> classIds, String authId) async {
    Map<String, dynamic> body = {"authId": authId, "classId": classIds};

    return [
      ClassModel(dateCreated: DateTime.now(), title: "Anatomy", id: "something", permissions: {
        "admin": ["Gianna"]
      }, topicsId: [
        "something",
        "sfdgf",
        "fgefbf"
      ]),
      ClassModel(dateCreated: DateTime.now(), title: "Chemistry", id: "something", permissions: {
        "admin": ["Celina"]
      }, topicsId: [
        "something",
        "sfdgf",
        "fgefbf"
      ]),
      ClassModel(dateCreated: DateTime.now(), title: "French", id: "something", permissions: {
        "admin": ["Sompa"]
      }, topicsId: [
        "something",
        "sfdgf",
        "fgefbf"
      ]),
      ClassModel(dateCreated: DateTime.now(), title: "Math", id: "something", permissions: {
        "admin": ["Michael"]
      }, topicsId: [
        "something",
        "sfdgf",
        "fgefbf"
      ])
    ];
    return client.post(Uri.parse(_baseUrl + '/get-classes'), headers: header, body: jsonEncode(body)).then((value) {
      dynamic result = jsonDecode(value.body);
      if (result == null) {
        return <ClassModel>[];
      } else {
        print("Result is $result");
        return (result as List).map((e) => ClassModel.fromJson(e)).toList();
      }
    }).catchError((error, stack) {
      print("Error getting classes: $error $stack");
      return <ClassModel>[];
    });
  }
}
