import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/features/portfolio/presentation/components/nav_bar/logo_widget.dart';

/// The mobile drawer widget for navigation.

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.experienceKey,
    required this.contactKey,
    required this.context,
    required this.scrollController,
  });
  //
  final BuildContext context;
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey experienceKey;
  final GlobalKey contactKey;

  final ScrollController scrollController;

  void scrollToSection(GlobalKey key) {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    Navigator.of(context).pop();
  }

  void scrollToTop() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    Navigator.of(context).pop();
  }

  //
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundDark,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
            ),
            child: const LogoWidget(),
          ),
          // "About"
          ListTile(title: const Text(AppStrings.about), onTap: scrollToTop),
          ListTile(
            title: const Text(AppStrings.skills),
            onTap: () => scrollToSection(skillsKey),
          ),
          ListTile(
            title: const Text(AppStrings.projects),
            onTap: () => scrollToSection(projectsKey),
          ),

          ListTile(
            title: const Text(AppStrings.experience),
            onTap: () => scrollToSection(experienceKey),
          ),
          ListTile(
            title: const Text(AppStrings.contact),
            onTap: () => scrollToSection(contactKey),
          ),
        ],
      ),
    );
  }
}
