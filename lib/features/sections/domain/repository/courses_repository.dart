import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';

abstract class CoursesRepository {
  Future<List<Course>> fetchAllCourses();

  Future<String> addCourse(Course course);

  Future<String> editCourse(Course course);

  Future<String> deleteCourse(String id);
}
