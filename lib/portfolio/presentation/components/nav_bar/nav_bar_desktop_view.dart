import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ismailmagdy/core/constants/app_strings.dart';
import 'package:ismailmagdy/core/theme/app_colors.dart';
import 'package:ismailmagdy/portfolio/presentation/components/nav_bar/logo_widget.dart';

class NavBarDesktopView extends StatefulWidget {
  const NavBarDesktopView({
    super.key,
    required this.scrollController,
    required this.screenWidth,
    required this.aboutKey,
    required this.projectsKey,
    required this.skillsKey,
    required this.packagesKey,
    required this.experienceKey,
  });

  final ScrollController scrollController;
  final double screenWidth;
  //
  final GlobalKey aboutKey;
  final GlobalKey projectsKey;
  final GlobalKey skillsKey;
  final GlobalKey packagesKey;
  final GlobalKey experienceKey;

  @override
  State<NavBarDesktopView> createState() => _NavBarDesktopViewState();
}

class _NavBarDesktopViewState extends State<NavBarDesktopView> {
  @override
  void dispose() {
    super.dispose();
  }

  bool _isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerLeft,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: const .only(top: 20, left: 24, right: 24),
        height: 64,
        width: widget.screenWidth - 48,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          borderRadius: .circular(32),
          border: .all(color: Colors.white.withValues(alpha: 0.1), width: 1),
        ),
        // Liquid glass effect
        child: ClipRRect(
          borderRadius: .circular(32),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: SingleChildScrollView(
              scrollDirection: .horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: SizedBox(
                width: widget.screenWidth - 48,
                height: 64,
                child: Stack(
                  alignment: .centerLeft,
                  children: [
                    // Logo
                    Positioned(
                      left: 0,
                      child: GestureDetector(
                        onTap: () => _scrollToTop(context),
                        child: Container(
                          width: 64,
                          height: 64,
                          alignment: .center,
                          child: const LogoWidget(),
                        ),
                      ),
                    ),
                    //
                    // Navigation
                    Positioned(
                      right: 20,
                      child: Row(
                        mainAxisSize: .min,
                        children: [
                          //
                          _buildNavItem(
                            AppStrings.about,
                            null,
                            onTap: () => _scrollToTop(context),
                          ),
                          //
                          const SizedBox(width: 20),
                          //
                          _buildNavItem(AppStrings.skills, widget.skillsKey),
                          //
                          const SizedBox(width: 20),
                          //
                          _buildNavItem(
                            AppStrings.projects,
                            widget.projectsKey,
                          ),
                          //
                          const SizedBox(width: 20),
                          //
                          _buildNavItem(
                            AppStrings.packages,
                            widget.packagesKey,
                          ),
                          //
                          _buildNavItem(
                            AppStrings.experience,
                            widget.experienceKey,
                          ),
                          //
                        ],
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String label, GlobalKey? key, {VoidCallback? onTap}) {
    return TextButton(
      onPressed: onTap ?? () => _scrollToSection(key!, context),
      style: TextButton.styleFrom(
        padding: const .symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: .circular(20)),
        foregroundColor: Colors.white.withValues(alpha: 0.1),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: .w500,
          color: AppColors.backgroundLight,
        ),
      ),
    );
  }

  ///
  void _scrollToTop(BuildContext context) {
    widget.scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    if (_isDrawerOpen) {
      Navigator.of(context).pop();
      setState(() => _isDrawerOpen = false);
    }
  }

  ///
  void _scrollToSection(GlobalKey key, BuildContext context) {
    final keyContext = key.currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
    if (_isDrawerOpen) {
      Navigator.of(context).pop();
      setState(() => _isDrawerOpen = false);
    }
  }
}
// 184
