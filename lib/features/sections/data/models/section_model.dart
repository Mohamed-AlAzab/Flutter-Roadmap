import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';

class SectionModel {
  final String id;
  final String title;
  final int order;
  final String description;
  final List<String> prerequisites;

  SectionModel({
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

  factory SectionModel.fromJson(Map<String, dynamic> courseModel) {
    return SectionModel(
      id: courseModel['id'] as String,
      title: courseModel['title'] as String,
      order: courseModel['order'] as int,
      description: courseModel['description'] as String,
      prerequisites: List<String>.from(courseModel['prerequisites'] ?? []),
    );
  }

  Section toEntity(double progress) {
    return Section(
      id: id,
      title: title,
      description: description,
      progress: progress,
      prerequisites: prerequisites,
    );
  }
}
