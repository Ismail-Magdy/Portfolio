import 'package:ismailmagdy/portfolio/models/experience/experience_model.dart';

class ExperienceRepository {
  List<ExperienceModel> getExperiences() {
    return [
      //
      ExperienceModel(
        id: "1",
        title: "Mobile Application Development Trainee",
        company: "National Telecommunication Institute (NTI)",
        period: "Dec 2025 - Mar 2026",
        description:
            "As a Mobile Application Development Trainee at NTI, I am enhancing my skills in Flutter and Dart, focusing on building cross-platform mobile applications. This role involves learning best practices in app development, user interface design, and integrating backend services. The training prepares me for real-world challenges in mobile software engineering.",
        technologies: [
          "Dart",
          "Flutter",
          "REST APIs",
          "Clean Architecture",
          "Firebase",
          "Git",
          "GitHub",
          "Agile Methodologies",
          "Team Collaboration",
        ],
      ),
      //
      ExperienceModel(
        id: "2",
        title: "Mobile Application Development Trainee",
        company: "IEEE BUB & IEEE Benha University Student Branch",
        period: "Oct 2025 - Present",
        description:
            "As a trainee at IEEE BUB, I completed an in-depth Flutter & Dart training program focused on cross-platform development. This comprehensive program covered mobile app architecture, state management, API integration, and best practices in Flutter development.",
        technologies: [
          "Flutter",
          "Dart",
          "Git",
          "GitHub",
          "Firebase",
          "State Management",
          "REST APIs",
        ],
      ),
      //
    ];
  }
}
