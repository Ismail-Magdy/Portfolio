class TeamMember {
  final String name;
  final String role;
  final String imagePath;

  const TeamMember({
    required this.name,
    required this.role,
    required this.imagePath,
  });
}

class ProjectModel {
  final String id;
  final String title;
  final String imageOut;
  final String imageIn;
  final String shortDescription;
  final String longDescription;
  final List<String> techStack;
  final bool isComingSoon;

  // Social & action links (nullable & buttons only render when non null)
  final String? linkedIn;
  final String? linkedInPartTwo;
  final String? instagram;
  final String? github;
  final String? tiktok;
  final String? websiteLink;
  final String? figmaLink;

  // Team members (nullable)
  final List<TeamMember>? teamMembers;

  ProjectModel({
    required this.id,
    required this.title,
    required this.imageOut,
    required this.imageIn,
    required this.shortDescription,
    required this.longDescription,
    required this.techStack,
    this.isComingSoon = false,
    this.linkedIn,
    this.linkedInPartTwo,
    this.instagram,
    this.github,
    this.tiktok,
    this.websiteLink,
    this.figmaLink,
    this.teamMembers,
  });
}
