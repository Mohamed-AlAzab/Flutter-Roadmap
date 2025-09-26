import 'package:flutter_roadmap/features/courses/domain/repository/courses_repository.dart';

class DeleteCourseUseCase {
  final CoursesRepository coursesRepository;

  DeleteCourseUseCase({required this.coursesRepository});

  Future<String> call(String id) async {
    return coursesRepository.deleteCourse(id);
  }
}
