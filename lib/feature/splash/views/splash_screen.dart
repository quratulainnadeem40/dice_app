import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: CustomColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: CustomColors.primaryPurple,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: CustomColors.primaryNeon.withOpacity(0.6),
                    blurRadius: 40,
                    spreadRadius: 10,
                  ),
                ],
              ),
              child: const Icon(Icons.casino_rounded, size: 70, color: Colors.white),
            ),
            const SizedBox(height: 24),
            const Text(
              'DICE ROLLER',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}