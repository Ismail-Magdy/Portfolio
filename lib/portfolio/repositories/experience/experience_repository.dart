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
        description: "Led The Software Development Team for The Smart Car Controller System Showcased at The MEGA Event. Architected and Developed a Real Time Mobile Application Using Flutter and Firebase To Wirelessly Control an ESP32-Based Robotic Car. Responsible For System Architecture, Achieving Zero Latency Data Synchronization, Mentoring Team Members on Dart and OOP concepts, and delivering the main technical presentation.",
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
        description: "As a Mobile Application Development Trainee at NTI, I am Enhancing My Skills in Flutter and Dart, Focusing on Building Cross Platform Mobile Applications. This Role Involves Learning Best Practices in App Development, User Interface Design, and Integrating Backend Services. The Training Prepares Me for Real World Challenges in Mobile Software Engineering.",
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
        description: "As a Trainee at IEEE BUB, I Completed An In Depth Flutter & Dart Training Program Focused on Cross Platform Development. This Comprehensive Program Covered Mobile App Architecture, State Management, API Integration, and Best Practices in Flutter Development.",
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
