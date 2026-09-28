import 'package:flutter/material.dart';

/// Manages the Blueprint / Mechatronics Mode state.
///
/// When [isBlueprintMode] is true, the UI switches from the default
/// minimalist dark theme to a technical engineering-blueprint aesthetic
/// with grid backgrounds, transparent cards, and monospace accents.
class BlueprintProvider extends ChangeNotifier {
  bool _isBlueprintMode = false;
  bool _hasEverToggled = false;

  bool get isBlueprintMode => _isBlueprintMode;

  /// Whether the user has ever toggled blueprint mode.
  /// Used by the discover hint to stop showing after first interaction.
  bool get hasEverToggled => _hasEverToggled;

  void toggleBlueprintMode() {
    _isBlueprintMode = !_isBlueprintMode;
    _hasEverToggled = true;
    notifyListeners();
  }
}
