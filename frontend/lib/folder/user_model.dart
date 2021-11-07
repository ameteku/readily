import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  String firstName;
  String lastName;
  List<String> classIds;
  String id;
  UserModel({required this.id, required this.classIds, required this.firstName, required this.lastName});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return _$UserModelFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$UserModelToJson(this);
  }
}
