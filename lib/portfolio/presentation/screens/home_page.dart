import 'package:flutter/material.dart';
import 'package:ismailmagdy/portfolio/presentation/components/skills/skills_section.dart';
import '../components/nav_bar/navbar.dart';
import '../components/nav_bar/mobile_bottom_navbar.dart';
import '../components/hero/components/hero_section.dart';
import '../components/projects/projects_section.dart';
import '../components/experience/experience_section.dart';
import '../components/open_source/open_source_section.dart';
import '../components/footer/footer.dart';
import '../components/background/animated_background.dart';

/// The main HomePage of the portfolio.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  int _activeIndex = 0;

  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final skillsKey = GlobalKey();
  final experienceKey = GlobalKey();
  final packagesKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final keys = [aboutKey, skillsKey, projectsKey, experienceKey, packagesKey];

    int newIndex = 0;
    for (int i = keys.length - 1; i >= 0; i--) {
      if (i == 0) {
        newIndex = 0;
        break;
      }
      final key = keys[i];
      if (key.currentContext != null) {
        final renderBox = key.currentContext!.findRenderObject() as RenderBox;
        final position = renderBox.localToGlobal(Offset.zero);
        if (position.dy < 400) {
          newIndex = i;
          break;
        }
      }
    }

    if (_activeIndex != newIndex) {
      setState(() {
        _activeIndex = newIndex;
      });
    }
  }

  void _onBottomNavTapped(int index) {
    if (index == 0) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
      final keys = [
        aboutKey,
        skillsKey,
        projectsKey,
        experienceKey,
        packagesKey,
      ];
      final keyContext = keys[index].currentContext;
      if (keyContext != null) {
        Scrollable.ensureVisible(
          keyContext,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 768;

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      // NavBar
      appBar: Navbar(
        aboutKey: aboutKey,
        projectsKey: projectsKey,
        skillsKey: skillsKey,
        packagesKey: packagesKey,
        experienceKey: experienceKey,
        scrollController: _scrollController,
      ),
      // Mobile Bottom Navbar
      bottomNavigationBar: isMobile
          ? MobileBottomNavbar(
              aboutKey: aboutKey,
              projectsKey: projectsKey,
              skillsKey: skillsKey,
              packagesKey: packagesKey,
              experienceKey: experienceKey,
              scrollController: _scrollController,
              activeIndex: _activeIndex,
              onTabTapped: _onBottomNavTapped,
            )
          : null,
      //
      body: Stack(
        children: [
          // Background Animation
          const Positioned.fill(child: AnimatedBackground()),
          // Content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Hero Section
                Container(key: aboutKey, child: HeroSection()),
                //
                // Skills Section
                Container(key: skillsKey, child: const SkillsSection()),
                //
                // Projects Section
                Container(key: projectsKey, child: const ProjectsSection()),
                //
                // Experience Section
                Container(key: experienceKey, child: const ExperienceSection()),
                //
                // Open Source & Packages Section
                Container(key: packagesKey, child: const OpenSourceSection()),
                //
                // Footer Section
                const Footer(),
                //
              ],
            ),
          ),
        ],
      ),
      //
    );
  }
}
