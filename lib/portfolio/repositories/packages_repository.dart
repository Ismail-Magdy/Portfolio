import 'package:ismailmagdy/portfolio/models/package_model.dart';

class PackagesRepository {
  List<PackageModel> getPackages() {
    return [
      PackageModel(
        title: 'Glass Bottom Navigation Bar',
        shortDescription:
            'A Beautiful, Modern, and Highly Customizable Glassmorphism Bottom Navigation Bar for Flutter Applications',
        imageOut: 'assets/images/glass_bottom_nav_bar.jpeg',
        imageIn: 'assets/images/glass-in.png',
        pubDevUrl: 'https://pub.dev/packages/glass_bottom_navigation_bar',
        githubUrl: 'https://github.com/Ismail-Magdy/glass_bottom_nav_bar',
        features: [
          'Modern Glassmorphism effect',
          'Highly customizable appearance',
          'Lightweight and easy to use',
          'Drop in replacement for standard BottomNavigationBar',
        ],
        installation: 'flutter pub add glass_bottom_navigation_bar',
        usage: '''Scaffold(
  extendBody: true,
  bottomNavigationBar: GlassBottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: (index) { ... },
    items: [ ... ],
  ),
);''',
      ),
    ];
  }
}
