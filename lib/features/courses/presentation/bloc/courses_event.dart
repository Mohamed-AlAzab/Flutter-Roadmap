part of 'courses_bloc.dart';

sealed class CoursesEvent extends Equatable {
  const CoursesEvent();

  @override
  List<Object> get props => [];
}

class GetCoursesEvent extends CoursesEvent {}

class AddCourseEvent extends CoursesEvent {
  final Course course;

  const AddCourseEvent(this.course);
}

class EditCourseEvent extends CoursesEvent {
  final Course course;

  const EditCourseEvent(this.course);
}

class DeleteCourseEvent extends CoursesEvent {
  final String id;

  const DeleteCourseEvent(this.id);
}
