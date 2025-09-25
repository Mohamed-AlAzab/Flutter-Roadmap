class Course {
  final String id;
  final String title;
  final String icon;
  final String name;
  final String description;
  final double progress;
  final List<String> prerequisites;

  Course({
    required this.id,
    required this.title,
    required this.icon,
    required this.name,
    required this.description,
    required this.progress,
    required this.prerequisites,
  });
}
