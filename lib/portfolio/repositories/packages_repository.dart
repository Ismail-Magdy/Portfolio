import 'package:ismailmagdy/portfolio/models/packages/package_model.dart';

class PackagesRepository {
  List<PackageModel> getPackages() {
    return [
      // First Package
      PackageModel(
        title: "Glass Bottom Navigation Bar",
        shortDescription:
            "A Beautiful, Modern, and Highly Customizable Glassmorphism Bottom Navigation Bar for Flutter Applications",
        imageOut: "assets/images/glass_bottom_nav_bar.jpeg",
        imageIn: "assets/images/glass-in.png",
        pubDevUrl: "https://pub.dev/packages/glass_bottom_navigation_bar",
        githubUrl: "https://github.com/Ismail-Magdy/glass_bottom_nav_bar",
        features: [
          "Modern Glassmorphism effect",
          "Highly customizable appearance",
          "Lightweight and easy to use",
          "Drop in replacement for standard BottomNavigationBar",
        ],
        installation: "flutter pub add glass_bottom_navigation_bar",
        usage: '''Scaffold(
  extendBody: true,
  bottomNavigationBar: GlassBottomNavigationBar(
    currentIndex: _currentIndex,
    onTap: (index) { ... },
    items: [ ... ],
  ),
);''',
      ),
      //
      // Second Package
      PackageModel(
        title: "Global Search Bar",
        shortDescription:
            "A powerful, highly customizable, and generic search bar for Flutter with built-in debouncing, search history, and text highlighting.",
        imageOut: "assets/images/search.png",
        imageIn: "assets/images/search.png",
        pubDevUrl: "https://pub.dev/packages/global_search_bar",
        githubUrl: "https://github.com/Ismail-Magdy/global_search_bar",
        features: [
          "Network & Local Search Support",
          "Built-in API Debouncer",
          "Automatic Search Text Highlighting",
          "Local Search History Management",
          "Headless UI for 100% customization freedom",
          "Zero external dependencies",
        ],
        installation: "flutter pub add global_search_bar",
        usage: '''GlobalSearchBar<Movie>(
  debounceDuration: const Duration(milliseconds: 600),
  searchCallback: (query) async {
    return await api.searchMovies(query);
  },
  onLoading: (isLoading) { 
    // Handle loading state
  },
  onResults: (results) { 
    // Handle results
  },
  onError: (error) {
    // Handle error state
  },
);''',
      ),
      //
    ];
  }
}
