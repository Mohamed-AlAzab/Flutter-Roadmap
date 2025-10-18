import 'package:flutter_roadmap/features/topic/domain/entity/topic.dart';

class TopicModel {
  final String id;
  final String title;
  final int order;
  final String description;
  final List<String> prerequisites;

  TopicModel({
    required this.id,
    required this.title,
    required this.order,
    required this.description,
    required this.prerequisites,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'order': order,
      'description': description,
      'prerequisites': prerequisites,
    };
  }

  factory TopicModel.fromJson(Map<String, dynamic> topicModel) {
    return TopicModel(
      id: topicModel['id'] as String,
      title: topicModel['title'] as String,
      order: topicModel['order'] as int,
      description: topicModel['description'] as String,
      prerequisites: List<String>.from(topicModel['prerequisites'] ?? []),
    );
  }

  Topic toEntity(bool isDone) {
    return Topic(
      id: id,
      title: title,
      description: description,
      isDone: isDone,
      prerequisites: prerequisites,
    );
  }
}
