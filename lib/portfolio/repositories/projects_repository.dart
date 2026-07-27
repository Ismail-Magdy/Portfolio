import 'package:ismailmagdy/core/constants/app_images.dart';
import 'package:ismailmagdy/portfolio/models/project_model.dart';

class ProjectsRepository {
  List<ProjectModel> getProjects() {
    return [
      //
      ProjectModel(
        id: "1",
        title: "Meal Monkey",
        imageOut: AppImages.mealMonkeyImageOut,
        imageIn: AppImages.mealMonkeyImageIn,
        shortDescription:
            "A complete food ordering & delivery app built with Flutter",
        longDescription:
            "Food & Delivery Mobile App built with Flutter. A complete food ordering and delivery application with user authentication, menu browsing, cart management, and order tracking. The app features a clean, modern UI with smooth animations and follows clean architecture principles for maintainability and scalability",
        techStack: ["Flutter", "Dart", "Clean Architecture", "REST API"],
        linkedIn:
            "https://www.linkedin.com/posts/ismailmagdy021_meal-monkey-food-delivery-mobile-app-activity-7382159246274117632-OgEV",
        instagram: "https://www.instagram.com/p/DPmilNtjf-W/",
        github: "https://github.com/Ismail-Magdy/Meal-Monkey",
      ),
      //
      ProjectModel(
        id: "2",
        title: "Book Shop",
        imageOut: AppImages.bookShopImageOut,
        imageIn: AppImages.bookShopImageIn,
        shortDescription: "An e-commerce app for browsing and purchasing books",
        longDescription:
            "Book Shop App for buying books. An e-commerce application for browsing and purchasing books with user-friendly interface and shopping cart functionality. Features include book categories, search, detailed book pages, and a seamless checkout experience powered by Firebase",
        techStack: ["Flutter", "Dart", "State Management", "Firebase"],
        linkedIn:
            "https://www.linkedin.com/posts/ismailmagdy021_book-store-a-simple-application-for-buying-activity-7395995024372477952-MGdS",
        instagram: "https://www.instagram.com/reel/DRI7ImcgnR6/",
        github: "https://github.com/Ismail-Magdy/Book_Shop",
      ),
      //
      ProjectModel(
        id: "3",
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
    ];
  }
}
