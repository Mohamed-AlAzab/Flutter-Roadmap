import 'package:flutter_roadmap/features/topic/domain/entity/topic.dart';

abstract class TopicsRepository {
  Future<List<Topic>> fetchAlltTopicsFromSection(String courseId, String sectionId);

  Future<String> addTopic(Topic topic, String courseId, String sectionId);

  Future<String> editTopic(Topic topic, String courseId, String sectionId);

  Future<String> deleteTopic(String id, String courseId, String sectionId);
}
