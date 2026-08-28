import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:dice_app/feature/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:dice_app/core/theme/colors_custom.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Splash Image
          Image.asset(
            'assets/imagesfolder/disciamge.png',
            fit: BoxFit.contain,
          ),

          // Loading Section
          Positioned(
            bottom: 115,
            left: 0,
            right: 0,
            child: Column(
              children: [
                // Loading Dots
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildLoadingDot(AppColors.violet),
                    const SizedBox(width: 14),
                    _buildLoadingDot(AppColors.purple),
                    const SizedBox(width: 14),
                    _buildLoadingDot(AppColors.purple),
                    const SizedBox(width: 14),
                    _buildLoadingDot(AppColors.purple),
                  ],
                ),

                const SizedBox(height: 28),

                // Loading Text
                const Text(
                  'L O A D I N G . . .',
                  style: AppTextStyles.loading,
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