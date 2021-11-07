import 'package:json_annotation/json_annotation.dart';
import 'note_model.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicModel {
  String topicName;
  List<String> resourceLinks;
  List<NoteModel> notes;

  TopicModel({required this.topicName, required this.resourceLinks, required this.notes});

  factory TopicModel.fromJson(Map<String, dynamic> data) {
    return _$TopicModelFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$TopicModelToJson(this);
  }

  @override
  String toString() {
    return 'TopicModel{topicName: $topicName, resourceLinks: $resourceLinks, Notes: $Notes}';
  }
}
