import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/theme/custom_color.dart';
import 'package:dice_app/core/theme/custom_textstyle.dart';
import 'package:dice_app/feature/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

          // Bottom Section
         Positioned(
  bottom: 115,
  left: 0,
  right: 0,
  child: Column(
    children: [
      // Tagline
      // const Text(
      //   'Roll it. Play it. Enjoy it.',
      //   style: TextStyle(
      //     color: Colors.white70,
      //     fontSize: 14,
      //   ),
      // ),

      const SizedBox(height: 24),

      // GET READY
      
         const Text(
          'G E T   R E A D Y . . .',
          style: AppTextStyles.loading,
        ),
    

      const SizedBox(height: 22),

      // Dots
     Obx(
  () => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      4,
      (index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: controller.activeDot.value == index ? 27 : 23,
          height: controller.activeDot.value == index ? 27 : 23,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: controller.activeDot.value == index
                ? AppColors.violet
                : AppColors.purple,
            boxShadow: [
              BoxShadow(
                color: (controller.activeDot.value == index
                        ? AppColors.violet
                        : AppColors.purple)
                    .withOpacity(0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
      ),
    ),
  ),
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