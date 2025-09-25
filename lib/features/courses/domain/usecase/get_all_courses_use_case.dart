import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/domain/repository/courses_repository.dart';

class GetAllCoursesUseCase {
  final CoursesRepository coursesRepository;

  GetAllCoursesUseCase({required this.coursesRepository});

  Future<List<Course>> call() async {
    return coursesRepository.fetchAllCourses();
  }
}
