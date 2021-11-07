// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
      topicName: json['topicName'] as String,
      resourceLinks: (json['resourceLinks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      notes: (json['notes'] as List<dynamic>)
          .map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'topicName': instance.topicName,
      'resourceLinks': instance.resourceLinks,
      'notes': instance.notes,
    };
