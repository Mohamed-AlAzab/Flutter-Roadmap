part of 'sections_bloc.dart';

sealed class SectionsState extends Equatable {
  const SectionsState();

  @override
  List<Object> get props => [];
}

final class SectionsInitial extends SectionsState {}

final class SectionsLoading extends SectionsState {}

final class SectionsLoaded extends SectionsState {
  final List<Section> sections;

  const SectionsLoaded(this.sections);
}

final class SectionsCreated extends SectionsState {
  final String message;

  const SectionsCreated(this.message);
}

final class SectionsEdited extends SectionsState {
  final String message;

  const SectionsEdited(this.message);
}

final class SectionsDeleted extends SectionsState {
  final String message;

  const SectionsDeleted(this.message);
}

final class SectionsError extends SectionsState {
  final String message;

  const SectionsError(this.message);
}
