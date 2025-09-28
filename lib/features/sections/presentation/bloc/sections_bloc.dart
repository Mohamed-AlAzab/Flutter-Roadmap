import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_roadmap/features/sections/domain/entity/section.dart';
import 'package:flutter_roadmap/features/sections/domain/usecase/add_section_use_case.dart';
import 'package:flutter_roadmap/features/sections/domain/usecase/delete_section_use_case.dart';
import 'package:flutter_roadmap/features/sections/domain/usecase/edit_section_use_case.dart';
import 'package:flutter_roadmap/features/sections/domain/usecase/get_all_sections_use_case.dart';

part 'sections_event.dart';
part 'sections_state.dart';

class SectionsBloc extends Bloc<SectionsEvent, SectionsState> {
  GetAllSectionsUseCase getAllSectionUsesCase;
  AddSectionUseCase addSectionUseCase;
  EditSectionUseCase editSectionUseCase;
  DeleteSectionUseCase deleteSectionUseCase;

  SectionsBloc({
    required this.getAllSectionUsesCase,
    required this.addSectionUseCase,
    required this.editSectionUseCase,
    required this.deleteSectionUseCase,
  }) : super(SectionsInitial()) {
    on<GetSectionsEvent>(onGetSectionsEvent);
    on<AddSectionEvent>(onAddSectionEvent);
    on<EditSectionEvent>(onEditSectionEvent);
    on<DeleteSectionEvent>(onDeleteSectionEvent);
  }

  FutureOr<void> onGetSectionsEvent(
    GetSectionsEvent event,
    Emitter<SectionsState> emit,
  ) async {
    emit(SectionsLoading());
    try {
      final courses = await getAllSectionUsesCase(event.courseId);
      emit(SectionsLoaded(courses));
    } catch (e) {
      emit(SectionsError(e.toString()));
    }
  }

  FutureOr<void> onAddSectionEvent(
    AddSectionEvent event,
    Emitter<SectionsState> emit,
  ) async {
    emit(SectionsLoading());
    try {
      await addSectionUseCase(event.section, event.courseId);
      emit(SectionsDeleted('Section Add Successfully'));
      add(GetSectionsEvent(event.courseId));
    } catch (e) {
      emit(SectionsError(e.toString()));
    }
  }

  FutureOr<void> onEditSectionEvent(
    EditSectionEvent event,
    Emitter<SectionsState> emit,
  ) async {
    emit(SectionsLoading());
    try {
      await editSectionUseCase(event.section, event.courseId);
      emit(SectionsDeleted('Section Edit Successfully'));
      add(GetSectionsEvent(event.courseId));
    } catch (e) {
      emit(SectionsError(e.toString()));
    }
  }

  FutureOr<void> onDeleteSectionEvent(
    DeleteSectionEvent event,
    Emitter<SectionsState> emit,
  ) async {
    emit(SectionsLoading());
    try {
      await deleteSectionUseCase(event.courseId, event.sectionId);
      emit(SectionsDeleted('Section Deleted Successfully'));
      add(GetSectionsEvent(event.courseId));
    } catch (e) {
      emit(SectionsError(e.toString()));
    }
  }
}
