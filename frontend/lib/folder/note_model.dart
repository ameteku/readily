import 'dart:typed_data';

import 'package:json_annotation/json_annotation.dart';

part 'note_model.g.dart';

@JsonSerializable()
class NoteModel {
  int noteId;
  bool isPrivate;
  DateTime uploadTime;
  int uploaderId;
  List noteByteImage;

  NoteModel(
      {required this.noteId, required this.isPrivate, required this.uploaderId, required this.noteByteImage, required this.uploadTime});

  factory NoteModel.fromJson(Map<String, dynamic> data) {
    return _$NoteModelFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$NoteModelToJson(this);
  }

  @override
  String toString() {
    return 'NoteModel{noteId: $noteId, isPrivate: $isPrivate, uploadTime: $uploadTime, uploaderId: $uploaderId, noteByteImage: $noteByteImage}';
  }
}
