import 'package:json_annotation/json_annotation.dart';

part 'class_model.g.dart';

@JsonSerializable()
class ClassModel {
  final String id;
  final String title;
  final DateTime dateCreated;
  final Map<String, List<String>> permissions;
  final List<String> topicsId;

  ClassModel({required this.id, required this.permissions, required this.title, required this.dateCreated, required this.topicsId});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return _$ClassModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$ClassModelToJson(this);
}
