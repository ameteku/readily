import 'package:json_annotation/json_annotation.dart';

part 'class_model.g.dart';

@JsonSerializable()
class ClassModel {
  final String id;
  final String title;
  final Map<String, List<String>> permissions;

  ClassModel({required this.id, required this.permissions, required this.title});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return _$ClassModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ClassModelToJson(this);
}
