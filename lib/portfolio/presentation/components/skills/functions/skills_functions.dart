import 'package:flutter/material.dart';

/// Returns an IconData for each skill name
IconData getSkillIcon(String name) {
  switch (name.toLowerCase()) {
    case "flutter":
      return Icons.flutter_dash;
    case "dart":
      return Icons.code;
    case "state management":
      return Icons.account_tree;
    case "clean architecture":
      return Icons.architecture;
    case "solid":
      return Icons.verified;
    case "mvvm":
      return Icons.layers;
    case "rest apis":
      return Icons.api;
    case "firebase":
      return Icons.local_fire_department;
    case "sqlite":
      return Icons.storage;
    case "supabase":
      return Icons.cloud;
    case "git":
      return Icons.merge_type;
    case "github":
      return Icons.hub;
    case "java":
      return Icons.coffee;
    case "c++":
      return Icons.terminal;
    case "python":
      return Icons.data_object;
    default:
      return Icons.star;
  }
}

/// Returns a proficiency level (0.0 – 1.0) for each skill
double getSkillLevel(String name) {
  switch (name.toLowerCase()) {
    case "flutter":
      return 0.92;
    case "dart":
      return 0.90;
    case "state management":
      return 0.85;
    case "clean architecture":
      return 0.80;
    case "solid":
      return 0.82;
    case "mvvm":
      return 0.78;
    case "rest apis":
      return 0.88;
    case "firebase":
      return 0.85;
    case "sqlite":
      return 0.70;
    case "supabase":
      return 0.65;
    case "git":
      return 0.88;
    case "github":
      return 0.85;
    case "java":
      return 0.60;
    case "c++":
      return 0.55;
    case "python":
      return 0.58;
    default:
      return 0.50;
  }
}
