import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';

abstract class SectionsRepository {
  Future<List<Section>> fetchAllSectionsFromCourse(String courseId);

  Future<String> addSection(Section section, String courseId);

  Future<String> editSection(Section section, String courseId);

  Future<String> deleteSection(String id, String courseId);
}
