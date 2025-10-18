part of 'topics_bloc.dart';

sealed class TopicsEvent extends Equatable {
  const TopicsEvent();

  @override
  List<Object> get props => [];
}

final class GetAllTopicsEvent extends TopicsEvent {
  final String courseId, sectionId;

  const GetAllTopicsEvent({required this.courseId, required this.sectionId});
}

final class AddTopicEvent extends TopicsEvent {
  final String courseId, sectionId;
  final Topic topic;

  const AddTopicEvent({
    required this.courseId,
    required this.sectionId,
    required this.topic,
  });
}

final class EditTopicEvent extends TopicsEvent {
  final String courseId, sectionId;
  final Topic topic;

  const EditTopicEvent({
    required this.courseId,
    required this.sectionId,
    required this.topic,
  });
}

final class DeleteTopicEvent extends TopicsEvent {
  final String courseId, sectionId, topicId;

  const DeleteTopicEvent({
    required this.courseId,
    required this.sectionId,
    required this.topicId,
  });
}
