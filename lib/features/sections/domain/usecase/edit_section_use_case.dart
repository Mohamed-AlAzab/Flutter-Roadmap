import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/sections/domain/repository/sections_repository.dart';

class EditSectionUseCase {
  final SectionsRepository sectionsRepository;

  EditSectionUseCase({required this.sectionsRepository});

  Future<String> call(Section section, String sectionId) async {
    return sectionsRepository.editSection(section, sectionId);
  }
}
