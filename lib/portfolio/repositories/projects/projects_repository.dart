import 'package:ismailmagdy/core/constants/app_images.dart';
import 'package:ismailmagdy/portfolio/models/projects/project_model.dart';

class ProjectsRepository {
  List<ProjectModel> getProjects() {
    return [
      //
      // Rentora
      ProjectModel(
        id: "0",
        title: "Rentora",
        imageOut: "assets/images/projects/rentora.jpeg",
        imageIn: "assets/images/projects/rentora.jpeg",
        shortDescription: "Peer-to-Peer (P2P) rental marketplace platform",
        longDescription:
            "Rentora is a robust P2P rental platform built with a Lite Clean Architecture (Feature-First). It features a secure AI integrated verification system, real time chat, interactive maps with GeoQueries, and advanced booking lifecycles. The app is powered by Firebase services (Auth, Firestore, Messaging) and utilizes BLoC&Cubit for state management and GetIt for dependency injection",
        techStack: [
          "Flutter",
          "Dart",
          "Clean Architecture",
          "BLoC & Cubit",
          "Firebase Firestore",
          "Firebase Auth",
          "Cloudinary",
          "GetIt",
          "flutter_map",
        ],
        github: "https://github.com/Ismail-Magdy/rentora",
        linkedIn: "https://lnkd.in/p/dMTsXaMF",
        teamMembers: [
          TeamMember(
            name: "Ismail Magdy",
            role: "Team Leader & Flutter Developer",
            imagePath: "assets/images/rentora/ismail.jpeg",
          ),
          TeamMember(
            name: "Essam Ibrahim",
            role: "Flutter Developer",
            imagePath: "assets/images/rentora/essam.jpeg",
          ),
          TeamMember(
            name: "Ghada Essam",
            role: "Flutter Developer",
            imagePath: "assets/images/rentora/ghada.jpeg",
          ),
          TeamMember(
            name: "Wesssm Zakaria",
            role: "Flutter Developer",
            imagePath: "assets/images/rentora/wessam.jpeg",
          ),
          TeamMember(
            name: "Kerols Gamal",
            role: "Flutter Developer",
            imagePath: "assets/images/rentora/kero.jpeg",
          ),
        ],
        isComingSoon: false,
      ),
      //
      // Joby App
      ProjectModel(
        id: "1",
        title: "Joby App",
        imageOut: AppImages.jobyImageOut,
        imageIn: AppImages.jobyImageIn,
        shortDescription:
            "A gamified job search platform built with Flutter & Supabase",
        longDescription:
            "Job search application built with Flutter. A platform for finding and applying to job opportunities with user authentication and job management features. Joby brings a gamified approach to the job hunt, making the process engaging and rewarding. Built with clean architecture and Cubit state management for a robust, scalable experience",
        techStack: [
          "Flutter",
          "Dart",
          "Supabase",
          "Clean Architecture",
          "Cubit",
        ],
        linkedIn:
            "https://www.linkedin.com/posts/ismailmagdy021_...-activity-7486106610776309761-UY6j",
        linkedInPartTwo:
            "https://www.linkedin.com/posts/ismailmagdy021_...-activity-7486468998553907200-5qSW",
        tiktok: "https://vt.tiktok.com/ZS41S5Lnk/",
        github: "https://github.com/Ismail-Magdy/Joby-ReadMe",
      ),
      //
      // Meal Monkey
      ProjectModel(
        id: "2",
        title: "Meal Monkey",
        imageOut: AppImages.mealMonkeyImageOut,
        imageIn: AppImages.mealMonkeyImageIn,
        shortDescription:
            "A complete food ordering & delivery app built with Flutter",
        longDescription:
            "A pixel perfect food delivery mobile app UI built entirely with Flutter and Dart. This frontend only project simulates a complete user journey across 20+ screens, including onboarding, restaurant browsing, checkout flows, and an interactive Google Maps integration. It showcases a scalable feature-first architecture, custom reusable components, and state management using BLoC&Cubit, without relying on a live backend.",
        techStack: [
          "Flutter",
          "Dart",
          "BLoC&Cubit",
          "Google Maps SDK",
          "Feature Based Architecture",
        ],
        linkedIn:
            "https://www.linkedin.com/posts/ismailmagdy021_meal-monkey-food-delivery-mobile-app-activity-7382159246274117632-OgEV",
        instagram: "https://www.instagram.com/p/DPmilNtjf-W/",
        github: "https://github.com/Ismail-Magdy/Meal-Monkey",
      ),
      //
      // Book Shop
      ProjectModel(
        id: "3",
        title: "Book Shop",
        imageOut: AppImages.bookShopImageOut,
        imageIn: AppImages.bookShopImageIn,
        shortDescription:
            "A polished, feature rich mobile bookstore UI built with Flutter and Dart",

        longDescription:
            "A frontend only mobile bookstore interface built entirely with Flutter. This project focuses on complex UI composition, smooth animations, and responsive design across multiple screens. It implements a feature based architecture, a custom draggable floating navigation bar, interactive carousels, and Firebase Authentication scaffolding, created specifically to showcase advanced frontend development skills.",

        techStack: [
          "Flutter",
          "Dart",
          "Firebase Auth",
          "Feature Based Architecture",
          "UI Animations",
        ],
        linkedIn:
            "https://www.linkedin.com/posts/ismailmagdy021_book-store-a-simple-application-for-buying-activity-7395995024372477952-MGdS",
        instagram: "https://www.instagram.com/reel/DRI7ImcgnR6/",
        github: "https://github.com/Ismail-Magdy/Book_Shop",
      ),
      //
      // Joby Website
      ProjectModel(
        id: "4",
        title: "Joby Website",
        imageOut: AppImages.jobySiteImageOut,
        imageIn: AppImages.jobySiteImageIn,
        shortDescription:
            "A modern landing page for the Joby recruitment platform",
        longDescription:
            "A modern, responsive landing page for the Joby recruitment application. It showcases the platform's gamified features, user journeys, and provides access to the beta version. Built with React, TypeScript, and Vite for a blazing-fast, SEO-friendly web experience with beautiful CSS animations",
        techStack: ["React", "TypeScript", "Vite", "CSS"],
        linkedIn: "https://www.linkedin.com/company/joby-application/",
        websiteLink: "https://joby-site.vercel.app/",
        tiktok: "https://vt.tiktok.com/ZS41S6KqB/",
        github: "https://github.com/Ismail-Magdy/joby-site",
      ),
      //
      // Portfolio
      ProjectModel(
        id: "5",
        title: "Portfolio",
        imageOut: AppImages.portfolioImageOut,
        imageIn: AppImages.portfolioImageIn,
        shortDescription: "Personal portfolio website built with Flutter Web",
        longDescription:
            "Personal portfolio website built with Flutter Web. Showcasing projects, skills, and professional information with responsive design and dark theme support. Features smooth animations, an animated background, and a fully responsive layout that works beautifully across desktop, tablet, and mobile devices",
        techStack: ["Flutter", "Dart", "Web", "Clean Architecture"],
        linkedIn:
            "https://www.linkedin.com/posts/ismailmagdy021_...-activity-7414697353032724480-_uzp",
        github: "https://github.com/Ismail-Magdy/Portfolio",
      ),
      //
      // Spotify
      ProjectModel(
        id: "6",
        title: "Spotify ",
        imageOut: AppImages.spotifyImageOut,
        imageIn: AppImages.spotifyImageIn,
        shortDescription:
            "A full-stack Spotify-inspired music streaming app built with Flutter & Firebase",
        longDescription:
            "A full-stack, cross-platform music streaming application inspired by Spotify, delivering a seamless audio entertainment experience. The app features secure Firebase Authentication, real-time music streaming with persistent playback, dynamic light and dark themes, and media browsing powered by Firebase Firestore and Cloud Storage. Built using Clean Architecture with a feature-first structure, Cubit state management, dependency injection, and functional error handling to ensure scalability, maintainability, and a smooth user experience",
        techStack: [
          "Flutter",
          "Dart",
          "Firebase Auth",
          "Cloud Firestore",
          "Cloud Storage",
          "just_audio",
          "Clean Architecture",
          "Cubit",
          "get_it",
          "dartz",
        ],
        figmaLink:
            "https://www.figma.com/design/2103XeJJzjY4lwqVOxsIIi/Spotify?node-id=0-1&t=2hZ30l3PKcADCNAc-1",
        github: "https://github.com/Ismail-Magdy/spotify",
        isComingSoon: true,
      ),
      //
      // Sytar
      ProjectModel(
        id: "7",
        title: "Sytar",
        imageOut: AppImages.sytarImageOut,
        imageIn: AppImages.sytarImageOut,
        shortDescription:
            "A mobile application to assist university students in managing academic tracks, marks, and exam dates",
        longDescription:
            "A mobile application to assist university students in managing academic tracks, marks, and exam dates",
        techStack: ["Flutter", "Dart"],
        isComingSoon: true,
      ),
      //
    ];
  }
}
