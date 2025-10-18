import 'package:flutter_roadmap/features/topic/domain/repository/topics_repository.dart';

class DeleteTopicUseCase {
  final TopicsRepository topicsRepository;

  DeleteTopicUseCase({required this.topicsRepository});

  Future<String> call(String id, String courseId, String sectionId) async {
    return topicsRepository.deleteTopic(id, courseId, sectionId);
  }
}
