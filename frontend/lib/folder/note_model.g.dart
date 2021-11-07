// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteModel _$NoteModelFromJson(Map<String, dynamic> json) => NoteModel(
      noteId: json['noteId'] as int,
      isPrivate: json['isPrivate'] as bool,
      uploaderId: json['uploaderId'] as int,
      noteByteImage: json['noteByteImage'] as List<dynamic>,
      uploadTime: DateTime.parse(json['uploadTime'] as String),
    );

Map<String, dynamic> _$NoteModelToJson(NoteModel instance) => <String, dynamic>{
      'noteId': instance.noteId,
      'isPrivate': instance.isPrivate,
      'uploadTime': instance.uploadTime.toIso8601String(),
      'uploaderId': instance.uploaderId,
      'noteByteImage': instance.noteByteImage,
    };
