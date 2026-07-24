import 'package:flutter/material.dart';
import 'package:ismailmagdy/features/portfolio/presentation/screens/home_page.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
