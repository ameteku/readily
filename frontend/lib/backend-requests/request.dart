import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
import 'package:readily/folder/class_model.dart';
import 'package:readily/folder/user_model.dart';

class BackendRequest {
  static const _baseUrl = "localhost:3000";
  final http.Client client;

  BackendRequest() : client = http.Client();

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
    return client.post(Uri.parse(_baseUrl + "/signup"), body: user.toJson()).then((value) {
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

  Future<List<ClassModel>?> getClasses(List<String> classIds, String authId) async {
    Map<String, dynamic> body = {"authId": authId, "classId": classIds};

    return client.post(Uri.parse(_baseUrl + '/classes'), body: jsonEncode(body)).then((value) {
      dynamic result = value.body;
      if (result == null) {
        return <ClassModel>[];
      } else {
        return (result as List).map((e) => ClassModel.fromJson(e)).toList();
      }
    }).catchError((error, stack) {
      print("Error signing in: $error $stack");
      return <ClassModel>[];
    });
  }
}
