import 'package:flutter_roadmap/features/topic/domain/entity/topic.dart';
import 'package:flutter_roadmap/features/topic/domain/repository/topics_repository.dart';

class EditTopicUseCase {
  final TopicsRepository topicsRepository;

  EditTopicUseCase({required this.topicsRepository});

  Future<String> call(Topic topic, String courseId, String sectionId) async {
    return topicsRepository.editTopic(topic, courseId, sectionId);
  }
}