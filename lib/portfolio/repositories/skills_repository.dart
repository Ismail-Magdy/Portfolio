import 'package:ismailmagdy/portfolio/models/skills/skill_model.dart';

class SkillsRepository {
  List<SkillModel> getSkills() {
    return [
      // Mobile
      const SkillModel(id: "1", name: "Flutter", category: "Mobile"),
      const SkillModel(id: "2", name: "Dart", category: "Mobile"),
      const SkillModel(id: "3", name: "State Management", category: "Mobile"),

      // Architecture
      const SkillModel(
        id: "4",
        name: "Clean Architecture",
        category: "Architecture",
      ),
      const SkillModel(id: "5", name: "SOLID", category: "Architecture"),
      const SkillModel(id: "6", name: "MVVM", category: "Architecture"),

      // Backend & DB
      const SkillModel(id: "7", name: "REST APIs", category: "Backend & DB"),
      const SkillModel(id: "8", name: "Firebase", category: "Backend & DB"),
      const SkillModel(id: "9", name: "SQLite", category: "Backend & DB"),
      const SkillModel(id: "17", name: "Supabase", category: "Backend & DB"),

      // Tools
      const SkillModel(id: "10", name: "Git", category: "Tools"),
      const SkillModel(id: "11", name: "GitHub", category: "Tools"),

      // Languages
      const SkillModel(id: "12", name: "Java", category: "Languages"),
      const SkillModel(id: "13", name: "C++", category: "Languages"),
      const SkillModel(id: "14", name: "Python", category: "Languages"),
    ];
  }
}
