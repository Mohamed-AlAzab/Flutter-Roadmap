part of 'sections_bloc.dart';

sealed class SectionsEvent extends Equatable {
  const SectionsEvent();

  @override
  List<Object> get props => [];
}

final class GetSectionsEvent extends SectionsEvent {
  final String courseId;

  const GetSectionsEvent(this.courseId);
}

final class AddSectionEvent extends SectionsEvent {
  final Section section;
  final String courseId;

  const AddSectionEvent(this.section, this.courseId);
}

final class EditSectionEvent extends SectionsEvent {
  final Section section;
  final String courseId;

  const EditSectionEvent(this.section, this.courseId);
}

final class DeleteSectionEvent extends SectionsEvent {
  final String sectionId, courseId;

  const DeleteSectionEvent(this.sectionId, this.courseId);
}
