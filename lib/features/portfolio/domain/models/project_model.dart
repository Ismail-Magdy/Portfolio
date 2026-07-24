class ProjectModel {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final List<String> techStack;
  final String githubUrl;
  final String? liveDemoUrl;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.techStack,
    required this.githubUrl,
    this.liveDemoUrl,
  });
}
