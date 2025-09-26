import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';

class CourseModel {
  final String id;
  final String title;
  final String icon;
  final String name;
  final int order;
  final String description;
  final List<String> prerequisites;

  CourseModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.name,
    required this.order,
    required this.description,
    required this.prerequisites,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
      'name': name,
      'order': order,
      'description': description,
      'prerequisites': prerequisites,
    };
  }

  factory CourseModel.fromJson(Map<String, dynamic> courseModel) {
    return CourseModel(
      id: courseModel['id'] as String,
      title: courseModel['title'] as String,
      icon: courseModel['icon'] as String,
      name: courseModel['name'] as String,
      order: courseModel['order'] as int,
      description: courseModel['description'] as String,
      prerequisites: List<String>.from(courseModel['prerequisites'] ?? []),
    );
  }

  Course toEntity(double progress) {
    return Course(
      id: id,
      title: title,
      icon: icon,
      name: name,
      description: description,
      progress: progress,
      prerequisites: prerequisites,
    );
  }
}
