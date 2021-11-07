import 'dart:convert';

import 'package:http/http.dart' as http;
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

    client.post(Uri.parse(_baseUrl + "/signin"), body: body).then((value) {
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
    client.post(Uri.parse(_baseUrl + "/signup"), body: user.toJson()).then((value) {
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
}
