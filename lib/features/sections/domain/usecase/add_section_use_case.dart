import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/sections/domain/repository/sections_repository.dart';

class AddSectionUseCase {
  final SectionsRepository sectionsRepository;

  AddSectionUseCase({required this.sectionsRepository});

  Future<String> call(Section section, String sectionId) async {
    return sectionsRepository.addSection(section, sectionId);
  }
}
