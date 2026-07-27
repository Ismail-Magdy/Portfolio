import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';

class MobileBottomNavbar extends StatelessWidget {
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey packagesKey;
  final GlobalKey experienceKey;
  final ScrollController scrollController;
  final int activeIndex;
  final Function(int) onTabTapped;

  const MobileBottomNavbar({
    super.key,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.packagesKey,
    required this.experienceKey,
    required this.scrollController,
    required this.activeIndex,
    required this.onTabTapped,
  });

  void _scrollToTop() {
    onTabTapped(0);
  }

  void _scrollToSection(GlobalKey key, int index) {
    onTabTapped(index);
  }

  Widget _buildNavItem(
    String label,
    GlobalKey? key,
    int index, {
    VoidCallback? onTap,
  }) {
    final isActive = activeIndex == index;
    return Padding(
      padding: const .symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: onTap ?? () => _scrollToSection(key!, index),
        style: TextButton.styleFrom(
          padding: const .symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: .circular(20)),
          backgroundColor: isActive
              ? Colors.white.withValues(alpha: 0.15)
              : Colors.transparent,
          foregroundColor: Colors.white.withValues(alpha: 0.1),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isActive ? .w600 : .w500,
            color: isActive
                ? AppColors.backgroundLight
                : AppColors.backgroundLight.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const .only(bottom: 20, left: 16, right: 16),
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: .circular(32),
          border: .all(color: Colors.white.withValues(alpha: 0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: .circular(32),
          child: BackdropFilter(
            filter: .blur(sigmaX: 12, sigmaY: 12),
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              padding: const .symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: .center,
                children: [
                  _buildNavItem(AppStrings.about, null, 0, onTap: _scrollToTop),
                  _buildNavItem(AppStrings.skills, skillsKey, 1),
                  _buildNavItem(AppStrings.projects, projectsKey, 2),
                  _buildNavItem(AppStrings.experience, experienceKey, 3),
                  _buildNavItem(AppStrings.packages, packagesKey, 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
// 105