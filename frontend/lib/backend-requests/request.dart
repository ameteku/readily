import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:readily/folder/user_model.dart';

class BackendRequest {
  static const _baseUrl = "localhost:3000";
  late http.Client client;

  Future<bool> connectToBackend() async {
    client = http.Client();
    var result = (await client.post(Uri.parse(_baseUrl))).body;

    if (result != null) return true;
    return false;
  }

  Future<UserModel?> loginUser(String email, String password) async {
    if (client == null) {
      await connectToBackend();
    }
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
}
