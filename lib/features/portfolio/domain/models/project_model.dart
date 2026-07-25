class ProjectModel {
  final String id;
  final String title;
  final String description;

  final List<String> techStack;
  final String githubUrl;
  final String? liveDemoUrl;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,

    required this.techStack,
    required this.githubUrl,
    this.liveDemoUrl,
  });
}
