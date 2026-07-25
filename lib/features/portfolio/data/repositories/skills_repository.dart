import 'package:ismailmagdy/features/portfolio/domain/models/skill_model.dart';

class SkillsRepository {
  List<SkillModel> getSkills() {
    return [
      // Mobile
      const SkillModel(id: "1", name: "Flutter", category: "Mobile"),
      const SkillModel(id: "2", name: "Dart", category: "Mobile"),

      // Architecture
      const SkillModel(
        id: "3",
        name: "Clean Architecture",
        category: "Architecture",
      ),
      const SkillModel(id: "4", name: "SOLID", category: "Architecture"),
      const SkillModel(id: "5", name: "MVVM", category: "Architecture"),

      // Backend & DB
      const SkillModel(id: "6", name: "REST APIs", category: "Backend & DB"),
      const SkillModel(id: "7", name: "Firebase", category: "Backend & DB"),
      const SkillModel(id: "8", name: "SQLite", category: "Backend & DB"),

      // Tools
      const SkillModel(id: "9", name: "Git", category: "Tools"),

      // Languages
      const SkillModel(id: "10", name: "Java", category: "Languages"),
      const SkillModel(id: "11", name: "C++", category: "Languages"),
      const SkillModel(id: "12", name: "Python", category: "Languages"),
    ];
  }
}
