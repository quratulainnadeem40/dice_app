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
          // Splash Image (Exact original style)
          Image.asset( 
            'assets/imagesfolder/disciamge.png', 
            fit: BoxFit.contain, 
          ), 

          // Bottom Section (Replaced text & dots with progress bar & percentage)
          Positioned( 
            bottom: 115, 
            left: 0, 
            right: 0, 
            child: AnimatedBuilder(
              animation: controller.loadingAnimation,
              builder: (context, child) {
                final double value = controller.loadingAnimation.value;
                final int percentage = (value * 100).toInt();

                return Column( 
                  children: [ 
                    // 0% - 100% Progress Bar
                    SizedBox(
                      width: 220,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: value,
                          backgroundColor: AppColors.purple.withValues(alpha: 0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.violet),
                          minHeight: 8,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16), 

                    // Percentage Text (0% to 100%)
                    Text( 
                      '$percentage%', 
                      style: AppTextStyles.loading, 
                    ), 
                  ], 
                );
              },
            ), 
          ), 
        ], 
      ), 
    ); 
  } 
}