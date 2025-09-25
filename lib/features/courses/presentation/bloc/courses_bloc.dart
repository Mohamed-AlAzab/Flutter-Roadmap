// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_roadmap/features/courses/domain/entity/course.dart';
import 'package:flutter_roadmap/features/courses/domain/usecase/add_course_use_case.dart';
import 'package:flutter_roadmap/features/courses/domain/usecase/delete_course_use_case.dart';
import 'package:flutter_roadmap/features/courses/domain/usecase/edit_course_use_case.dart';
import 'package:flutter_roadmap/features/courses/domain/usecase/get_all_courses_use_case.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<CoursesEvent, CoursesState> {
  GetAllCoursesUseCase getAllCoursesUseCase;
  AddCourseUseCase addCourseUseCase;
  EditCourseUseCase editCourseUseCase;
  DeleteCourseUseCase deleteCourseUseCase;

  CoursesBloc({
    required this.getAllCoursesUseCase,
    required this.addCourseUseCase,
    required this.editCourseUseCase,
    required this.deleteCourseUseCase,
  }) : super(CoursesInitial()) {
    on<GetCoursesEvent>(onGetCoursesEvent);
    on<AddCourseEvent>(onAddCourseEvent);
    on<EditCourseEvent>(onEditCourseEvent);
    on<DeleteCourseEvent>(onDeleteCourseEvent);
  }

  FutureOr<void> onGetCoursesEvent(
    GetCoursesEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());
    try {
      final courses = await getAllCoursesUseCase();
      emit(CoursesLoaded(courses));
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }

  FutureOr<void> onAddCourseEvent(
    AddCourseEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());
    try {
      final message = await addCourseUseCase(event.course);
      emit(CoursesAdded(message));
      add(GetCoursesEvent());
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }

  FutureOr<void> onEditCourseEvent(
    EditCourseEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());
    try {
      final message = await editCourseUseCase(event.course);
      emit(CoursesEdited(message));
      add(GetCoursesEvent());
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }

  FutureOr<void> onDeleteCourseEvent(
    DeleteCourseEvent event,
    Emitter<CoursesState> emit,
  ) async {
    emit(CoursesLoading());
    try {
      final message = await deleteCourseUseCase(event.id);
      emit(CoursesDelete(message));
      add(GetCoursesEvent());
    } catch (e) {
      emit(CoursesError(e.toString()));
    }
  }
}
