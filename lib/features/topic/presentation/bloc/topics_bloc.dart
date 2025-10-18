import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_roadmap/features/topic/domain/entity/topic.dart';
import 'package:flutter_roadmap/features/topic/domain/usecase/add_topic_use_case.dart';
import 'package:flutter_roadmap/features/topic/domain/usecase/delete_topic_use_case.dart';
import 'package:flutter_roadmap/features/topic/domain/usecase/edit_topic_use_case.dart';
import 'package:flutter_roadmap/features/topic/domain/usecase/get_all_topics_use_case.dart';

part 'topics_event.dart';
part 'topics_state.dart';

class TopicsBloc extends Bloc<TopicsEvent, TopicsState> {
  GetAllTopicsUseCase getAllTopicsUseCase;
  AddTopicUseCase addTopicUseCase;
  EditTopicUseCase editTopicUseCase;
  DeleteTopicUseCase deleteTopicUseCase;

  TopicsBloc({
    required this.getAllTopicsUseCase,
    required this.addTopicUseCase,
    required this.editTopicUseCase,
    required this.deleteTopicUseCase,
  }) : super(TopicsInitial()) {
    on<GetAllTopicsEvent>(onGetAllTopicsEvent);
    on<AddTopicEvent>(onAddTopicEvent);
    on<EditTopicEvent>(onEditTopicEvent);
    on<DeleteTopicEvent>(onDeleteTopicEvent);
  }

  FutureOr<void> onGetAllTopicsEvent(
    GetAllTopicsEvent event,
    Emitter<TopicsState> emit,
  ) async {
    emit(TopicsLoading());
    try {
      final topics = await getAllTopicsUseCase(event.courseId, event.sectionId);
      emit(TopicsLoaded(topics));
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }

  FutureOr<void> onAddTopicEvent(
    AddTopicEvent event,
    Emitter<TopicsState> emit,
  ) async {
    emit(TopicsLoading());
    try {
      final topics = await addTopicUseCase(
        event.topic,
        event.courseId,
        event.sectionId,
      );
      emit(TopicAdded('Topic Add Successfully'));
      add(
        GetAllTopicsEvent(courseId: event.courseId, sectionId: event.sectionId),
      );
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }

  FutureOr<void> onEditTopicEvent(
    EditTopicEvent event,
    Emitter<TopicsState> emit,
  ) async {
    emit(TopicsLoading());
    try {
      final topics = await editTopicUseCase(
        event.topic,
        event.courseId,
        event.sectionId,
      );
      emit(TopicEdited('Topic Edited Successfully'));
      add(
        GetAllTopicsEvent(courseId: event.courseId, sectionId: event.sectionId),
      );
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }

  FutureOr<void> onDeleteTopicEvent(
    DeleteTopicEvent event,
    Emitter<TopicsState> emit,
  ) async {
    emit(TopicsLoading());
    try {
      final topics = await deleteTopicUseCase(
        event.topicId,
        event.courseId,
        event.sectionId,
      );
      emit(TopicDeleted('Topic Deleted Successfully'));
      add(
        GetAllTopicsEvent(courseId: event.courseId, sectionId: event.sectionId),
      );
    } catch (e) {
      emit(TopicError(e.toString()));
    }
  }
}
