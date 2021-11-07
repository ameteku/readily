// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopicModel _$TopicModelFromJson(Map<String, dynamic> json) => TopicModel(
      topicId: json['topicId'] as int,
      topicName: json['topicName'] as String,
      resourceLinks: (json['resourceLinks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      noteIds: (json['noteIds'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$TopicModelToJson(TopicModel instance) =>
    <String, dynamic>{
      'topicId': instance.topicId,
      'topicName': instance.topicName,
      'resourceLinks': instance.resourceLinks,
      'noteIds': instance.noteIds,
    };
