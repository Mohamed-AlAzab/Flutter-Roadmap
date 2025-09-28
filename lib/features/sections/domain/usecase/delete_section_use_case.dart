import 'package:flutter_roadmap/features/sections/domain/repository/sections_repository.dart';


class DeleteSectionUseCase {
  final SectionsRepository sectionsRepository;

  DeleteSectionUseCase({required this.sectionsRepository});

  Future<String> call(String sectionId, String courseId) async {
    return sectionsRepository.deleteSection(courseId, sectionId);
  }
}
