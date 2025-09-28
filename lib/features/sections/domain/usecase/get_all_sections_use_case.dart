import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/sections/domain/repository/sections_repository.dart';

class GetAllSectionsUseCase {
  final SectionsRepository sectionsRepository;

  GetAllSectionsUseCase({required this.sectionsRepository});

  Future<List<Section>> call(String couresId) async {
    return await sectionsRepository.fetchAllSectionsFromCourse(couresId);
  }
}
