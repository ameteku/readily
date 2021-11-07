import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String firstName;
  String lastName;
  String email;
  String? password;
  List<String> classIds;
  String? id;
  UserModel({this.id, required this.classIds, required this.firstName, required this.lastName, required this.email, this.password});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return _$UserModelFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }
}
