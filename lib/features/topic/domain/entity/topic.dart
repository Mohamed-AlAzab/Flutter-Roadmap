class Topic {
  final String id;
  final String title;
  final String description;
  final bool isDone;
  final List<String> prerequisites;

  Topic({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
    required this.prerequisites,
  });
}
