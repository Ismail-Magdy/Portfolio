import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ismailmagdy/core/theme/blueprint_provider.dart';
import 'package:ismailmagdy/portfolio/presentation/screens/splash_screen.dart';

class Portfolio extends StatelessWidget {
  const Portfolio({super.key});

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (_) => BlueprintProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    ),
  );
}
