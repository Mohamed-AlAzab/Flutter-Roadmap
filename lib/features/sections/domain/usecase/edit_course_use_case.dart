import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/domain/repository/courses_repository.dart';

class EditCourseUseCase {
  final CoursesRepository coursesRepository;

  EditCourseUseCase({required this.coursesRepository});

  Future<String> call(Course course) async {
    return coursesRepository.editCourse(course);
  }
}
