import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';

class MobileBottomNavbar extends StatelessWidget {
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey contactKey;
  final GlobalKey experienceKey;
  final ScrollController scrollController;
  final int activeIndex;
  final Function(int) onTabTapped;

  const MobileBottomNavbar({
    super.key,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.contactKey,
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

  Widget _buildNavItem(String label, GlobalKey? key, int index, {VoidCallback? onTap}) {
    final isActive = activeIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: onTap ?? () => _scrollToSection(key!, index),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: isActive ? Colors.white.withOpacity(0.15) : Colors.transparent,
          foregroundColor: Colors.white.withOpacity(0.1), // Splash effect color
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
            color: isActive ? AppColors.backgroundLight : AppColors.backgroundLight.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
        height: 64,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(32),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildNavItem(AppStrings.about, null, 0, onTap: _scrollToTop),
                  _buildNavItem(AppStrings.skills, skillsKey, 1),
                  _buildNavItem(AppStrings.projects, projectsKey, 2),
                  _buildNavItem(AppStrings.experience, experienceKey, 3),
                  _buildNavItem(AppStrings.contact, contactKey, 4),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
