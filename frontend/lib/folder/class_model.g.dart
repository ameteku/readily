// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassModel _$ClassModelFromJson(Map<String, dynamic> json) => ClassModel(
      id: json['id'] as String,
      permissions: (json['permissions'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, (e as List<dynamic>).map((e) => e as String).toList()),
      ),
      title: json['title'] as String,
      dateCreated: DateTime.parse(json['dateCreated'] as String),
      topicsId:
          (json['topicsId'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ClassModelToJson(ClassModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'dateCreated': instance.dateCreated.toIso8601String(),
      'permissions': instance.permissions,
      'topicsId': instance.topicsId,
    };
