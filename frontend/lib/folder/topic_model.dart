import 'package:json_annotation/json_annotation.dart';
import 'note_model.dart';

part 'topic_model.g.dart';

@JsonSerializable()
class TopicModel {
  int topicId;
  String topicName;
  List<String> resourceLinks;
  List<int> noteIds;

  TopicModel({required this.topicId, required this.topicName, required this.resourceLinks, required this.noteIds});

  factory TopicModel.fromJson(Map<String, dynamic> data) {
    return _$TopicModelFromJson(data);
  }

  Map<String, dynamic> toJson() {
    return _$TopicModelToJson(this);
  }

  @override
  String toString() {
    return 'TopicModel{topicId: $topicId, topicName: $topicName, resourceLinks: $resourceLinks, noteIds: $noteIds}';
  }
}
