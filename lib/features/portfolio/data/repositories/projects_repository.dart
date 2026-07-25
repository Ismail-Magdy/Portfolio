import 'package:ismailmagdy/features/portfolio/domain/models/project_model.dart';

class ProjectsRepository {
  List<ProjectModel> getProjects() {
    return [
      //
      ProjectModel(
        id: "1",
        title: "Meal Monkey",
        description:
            "Food & Delivery Mobile App built with Flutter. A complete food ordering and delivery application with user authentication, menu browsing, cart management, and order tracking.",
        techStack: ["Flutter", "Dart", "Clean Architecture", "REST API"],
        githubUrl: "https://github.com/Ismail-Magdy/Meal-Monkey",
        liveDemoUrl: null,
      ),
      //
      ProjectModel(
        id: "2",
        title: 'Book Shop',
        description:
            "Book Shop App for buying books. An e-commerce application for browsing and purchasing books with user-friendly interface and shopping cart functionality.",
        techStack: ["Flutter", "Dart", "State Management", "Firebase"],
        githubUrl: "https://github.com/Ismail-Magdy/Book_Shop",
        liveDemoUrl: null,
      ),
      //
      ProjectModel(
        id: "3",
        title: "Portfolio Website",
        description:
            "Personal portfolio website built with Flutter Web. Showcasing projects, skills, and professional information with responsive design and dark/light theme support.",
        techStack: ["Flutter", "Dart", "Web", "Clean Architecture"],
        githubUrl: "https://github.com/Ismail-Magdy/Ismail-Magdy",
        liveDemoUrl: null,
      ),
      //
      ProjectModel(
        id: "4",
        title: "Joby App",
        description:
            "Job search application built with Flutter. A platform for finding and applying to job opportunities with user authentication and job management features.",
        techStack: [
          "Flutter",
          "Dart",
          "Supabase",
          "Clean Architecture",
          "Cubit",
        ],
        githubUrl: "https://github.com/Ismail-Magdy/joby",
        liveDemoUrl: null,
      ),
    ];
  }
}
