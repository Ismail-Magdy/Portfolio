import 'package:flutter/material.dart';
import 'package:ismailmagdy/core/constants/app_images.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
      child: const Center(
        child: CircleAvatar(
          backgroundImage: AssetImage(AppImages.logo),
          radius: 70,
        ),
      ),
    );
  }
}
