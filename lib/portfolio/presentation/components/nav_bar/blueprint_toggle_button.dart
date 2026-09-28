import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/theme/blueprint_provider.dart';

/// A subtle, animated toggle button that switches between
/// the default dark mode and Blueprint / Mechatronics Mode.
///
/// Includes a periodic "Discover Mode" hint tooltip that
/// pulses next to the button until the user toggles for the first time.
class BlueprintToggleButton extends StatefulWidget {
  const BlueprintToggleButton({super.key});

  @override
  State<BlueprintToggleButton> createState() => _BlueprintToggleButtonState();
}

class _BlueprintToggleButtonState extends State<BlueprintToggleButton>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _pulseController;
  bool _isHovered = false;
  bool _showHint = false;
  Timer? _initialShowTimer;
  Timer? _hideTimer;
  Timer? _periodicTimer;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _startHintCycle();
  }

  void _startHintCycle() {
    // Show hint after 4 seconds
    _initialShowTimer = Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      final provider = context.read<BlueprintProvider>();
      if (!provider.hasEverToggled) {
        setState(() => _showHint = true);
        _scheduleHide();
      }
    });

    // Periodic re-show every 30 seconds
    _periodicTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      if (!mounted) return;
      final provider = context.read<BlueprintProvider>();
      if (!provider.hasEverToggled) {
        setState(() => _showHint = true);
        _scheduleHide();
      }
    });
  }

  void _scheduleHide() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 5), () {
      if (mounted) setState(() => _showHint = false);
    });
  }

  void _cancelAllHints() {
    _initialShowTimer?.cancel();
    _hideTimer?.cancel();
    _periodicTimer?.cancel();
    if (mounted) setState(() => _showHint = false);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _pulseController.dispose();
    _initialShowTimer?.cancel();
    _hideTimer?.cancel();
    _periodicTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BlueprintProvider>();
    final isActive = provider.isBlueprintMode;

    // Cancel hints once user has toggled
    if (provider.hasEverToggled && (_showHint || _periodicTimer?.isActive == true)) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _cancelAllHints());
    }

    // Sync rotation animation
    if (isActive &&
        _rotationController.status != AnimationStatus.forward &&
        _rotationController.status != AnimationStatus.completed) {
      _rotationController.forward();
    } else if (!isActive &&
        _rotationController.status != AnimationStatus.reverse &&
        _rotationController.status != AnimationStatus.dismissed) {
      _rotationController.reverse();
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ─── Toggle Button ───
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              provider.toggleBlueprintMode();
              _cancelAllHints();
            },
            child: AnimatedBuilder(
              animation: _rotationController,
              builder: (context, child) {
                final progress =
                    Curves.easeOutCubic.transform(_rotationController.value);
                final rotation = progress * 0.5 * 3.14159;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isActive
                        ? AppColors.primary.withValues(alpha: 0.15)
                        : _isHovered
                            ? Colors.white.withValues(alpha: 0.08)
                            : Colors.transparent,
                    borderRadius: BorderRadius.circular(isActive ? 0 : 10),
                    border: Border.all(
                      color: isActive
                          ? AppColors.primary.withValues(alpha: 0.5)
                          : _isHovered
                              ? Colors.white.withValues(alpha: 0.15)
                              : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: Transform.rotate(
                    angle: rotation,
                    child: Icon(
                      Icons.architecture,
                      size: 20,
                      color: isActive
                          ? AppColors.primary
                          : _isHovered
                              ? Colors.white.withValues(alpha: 0.8)
                              : Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // ─── Discover Hint Tooltip ───
        if (!provider.hasEverToggled)
          Positioned(
            top: 48,
            right: 0,
            child: IgnorePointer(
              child: AnimatedOpacity(
                opacity: _showHint ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                child: AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final bounce = -1.5 + _pulseController.value * 3.0;
                    return Transform.translate(
                      offset: Offset(0, bounce),
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1128).withValues(alpha: 0.95),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('⚙️', style: TextStyle(fontSize: 13)),
                        const SizedBox(width: 6),
                        Text(
                          'Try Blueprint Mode',
                          style: GoogleFonts.firaCode(
                            fontSize: 11,
                            color: AppColors.primary,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
