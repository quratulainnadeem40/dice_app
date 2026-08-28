import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:dice_app/feature/splash/controller/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SplashScreen extends GetView<SplashController> {

  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,

      body: Stack(
        fit: StackFit.expand,
        children: [

          // =====================================================
          // BACKGROUND IMAGE
          // =====================================================

          Image.asset(
            'assets/imagesfolder/disciamge.png',
            fit: BoxFit.cover,

            errorBuilder: (
              context,
              error,
              stackTrace,
            ) {
              return Container(
                color: AppColors.background,
              );
            },
          ),

          // =====================================================
          // DARK OVERLAY
          // =====================================================

          Container(
            color: Colors.black.withOpacity(0.08),
          ),

          // =====================================================
          // CONTENT
          // =====================================================

          SafeArea(
            child: Column(
              children: [

                const Spacer(
                  flex: 6,
                ),

                // =================================================
                // DICE
                // =================================================

                const Text(
                  'DICE',
                  style: AppTextStyles.title,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 4,
                ),

                // =================================================
                // APP
                // =================================================

                const Text(
                  'A P P',
                  style: AppTextStyles.appName,
                  textAlign: TextAlign.center,
                ),

                const SizedBox(
                  height: 18,
                ),

                // =================================================
                // TAGLINE
                // =================================================

                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: Text.rich(
                    TextSpan(
                      children: [

                        TextSpan(
                          text: 'Roll it. ',
                          style: AppTextStyles.tagline,
                        ),

                        TextSpan(
                          text: 'Play it.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.violet,
                          ),
                        ),

                        TextSpan(
                          text: ' Enjoy it.',
                          style: AppTextStyles.tagline,
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                const Spacer(
                  flex: 3,
                ),

                // =================================================
                // ANIMATED LOADING DOTS
                // =================================================

                Obx(
                  () {
                    return Row(
                      mainAxisAlignment:
                          MainAxisAlignment.center,
                      children: List.generate(
                        4,
                        (index) {

                          final bool isActive =
                              controller.activeDot.value ==
                                  index;

                          return AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 250,
                            ),

                            margin:
                                const EdgeInsets.symmetric(
                              horizontal: 5,
                            ),

                            width:
                                isActive ? 10 : 8,

                            height:
                                isActive ? 10 : 8,

                            decoration:
                                BoxDecoration(
                              shape:
                                  BoxShape.circle,

                              color: isActive
                                  ? AppColors.violet
                                  : AppColors.purple
                                      .withOpacity(
                                      0.35,
                                    ),

                              boxShadow: isActive
                                  ? [
                                      BoxShadow(
                                        color: AppColors
                                            .violet
                                            .withOpacity(
                                          0.7,
                                        ),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ]
                                  : null,
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),

                const SizedBox(
                  height: 18,
                ),

                // =================================================
                // LOADING TEXT
                // =================================================

                const Text(
                  'LOADING...',
                  style: AppTextStyles.loading,
                ),

                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}