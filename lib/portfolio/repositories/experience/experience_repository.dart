import 'package:ismailmagdy/portfolio/models/experience/experience_model.dart';

class ExperienceRepository {
  List<ExperienceModel> getExperiences() {
    return [
      //
      ExperienceModel(
        id: "0",
        title: "Software Team Leader (IoT Project)",
        company: "MEGA Event - IEEE BUB & IEEE Benha University Student Branch",
        period: "Aug 2026 - Sep 2026",
        description:
            "Led the software development team for the Smart Car Controller System showcased at the MEGA Event. Architected and developed a real-time mobile application using Flutter and Firebase to wirelessly control an ESP32-based robotic car. Responsible for system architecture, achieving zero-latency data synchronization, mentoring team members on Dart and OOP concepts, and delivering the main technical presentation.",
        technologies: [
          "Dart",
          "Flutter",
          "Firebase Realtime Database",
          "IoT Integration (ESP32)",
          "OOP",
          "Team Collaboration",
          "Team Leadership",
          "Technical Presentation",
          "Problem Solving",
        ],
      ),
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
          "State Management",
          "SOLID Principles",
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
        title: "Mobile Application Development Member",
        company: "IEEE BUB & IEEE Benha University Student Branch",
        period: "Oct 2025 - Oct 2026",
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
          "Clean Architecture",
          "SOLID Principles",
        ],
      ),
      //
    ];
  }
}
