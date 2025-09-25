part of 'courses_bloc.dart';

sealed class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

final class CoursesInitial extends CoursesState {}

final class CoursesLoading extends CoursesState {}

final class CoursesLoaded extends CoursesState {
  final List<Course> courses;

  const CoursesLoaded(this.courses);
}

final class CoursesAdded extends CoursesState {
  final String message;

  const CoursesAdded(this.message);
}

final class CoursesEdited extends CoursesState {
  final String message;

  const CoursesEdited(this.message);
}

final class CoursesDelete extends CoursesState {
  final String message;

  const CoursesDelete(this.message);
}

final class CoursesError extends CoursesState {
  final String message;

  const CoursesError(this.message);
}
