import 'package:flutter/material.dart';
import 'package:ismailmagdy/portfolio/presentation/screens/splash_screen.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
