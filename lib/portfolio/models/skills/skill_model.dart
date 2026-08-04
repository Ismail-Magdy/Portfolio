class SkillModel {
  final String id;
  final String name;
  final String category;
  final String? icon;

  const SkillModel({
    required this.id,
    required this.name,
    required this.category,
    this.icon,
  });
}
