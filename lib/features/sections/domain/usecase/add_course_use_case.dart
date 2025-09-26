import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/domain/repository/courses_repository.dart';

class AddCourseUseCase {
  final CoursesRepository coursesRepository;

  AddCourseUseCase({required this.coursesRepository});

  Future<String> call(Course course) async {
    return coursesRepository.addCourse(course);
  }
}
