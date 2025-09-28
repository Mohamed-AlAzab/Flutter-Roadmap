class Section {
  final String id;
  final String title;
  final String description;
  final double progress;
  final List<String> prerequisites;

  Section({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.prerequisites,
  });
}
