import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/theme/colors_custom.dart'; // ✅ Updated Import
import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:dice_app/feature/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCustom.background, // ✅ Fixed

      body: Stack(
        fit: StackFit.expand,
        children: [
          // Splash Image
          Image.asset(
            'assets/imagesfolder/disciamge.png',
            fit: BoxFit.contain,
          ),

          // Bottom Section
          Positioned(
            bottom: 115,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const SizedBox(height: 24),

                // GET READY
                GestureDetector(
                  onTap: () {
                    Get.offNamed(Routes.INITIAL);
                  },
                  child: const Text(
                    'G E T   R E A D Y . . .',
                    style: TextStyle(
  color: Colors.white,
  fontSize: 16,
  fontWeight: FontWeight.bold,
  letterSpacing: 2.0,
),
                  ),
                ),

                const SizedBox(height: 22),

                // Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoadingDot(ColorsCustom.violet), // ✅ Fixed
                    const SizedBox(width: 14),
                    _buildLoadingDot(ColorsCustom.purple), // ✅ Fixed
                    const SizedBox(width: 14),
                    _buildLoadingDot(ColorsCustom.purple), // ✅ Fixed
                    const SizedBox(width: 14),
                    _buildLoadingDot(ColorsCustom.purple), // ✅ Fixed
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingDot(Color color) {
    return Container(
      width: 23,
      height: 23,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }
}