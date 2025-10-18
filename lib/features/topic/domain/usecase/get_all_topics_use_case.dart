import 'package:flutter_roadmap/features/topic/domain/entity/topic.dart';
import 'package:flutter_roadmap/features/topic/domain/repository/topics_repository.dart';

class GetAllTopicsUseCase {
  final TopicsRepository topicsRepository;

  GetAllTopicsUseCase({required this.topicsRepository});

  Future<List<Topic>> call(String couresId, String sectionId) async {
    return await topicsRepository.fetchAlltTopicsFromSection(
      couresId,
      sectionId,
    );
  }
}
