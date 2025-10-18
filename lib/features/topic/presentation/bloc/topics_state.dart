part of 'topics_bloc.dart';

sealed class TopicsState extends Equatable {
  const TopicsState();

  @override
  List<Object> get props => [];
}

final class TopicsInitial extends TopicsState {}

final class TopicsLoading extends TopicsState {}

final class TopicsLoaded extends TopicsState {
  final List<Topic> topics;

  const TopicsLoaded(this.topics);
}

final class TopicAdded extends TopicsState {
  final String message;

  const TopicAdded(this.message);
}

final class TopicEdited extends TopicsState {
  final String message;

  const TopicEdited(this.message);
}

final class TopicDeleted extends TopicsState {
  final String message;

  const TopicDeleted(this.message);
}

final class TopicError extends TopicsState {
  final String message;

  const TopicError(this.message);
}