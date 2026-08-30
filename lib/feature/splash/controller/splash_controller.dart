import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dice_app/core/routes/app_routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController loadingController;
  late Animation<double> loadingAnimation;

  final RxInt activeDot = 0.obs;
  bool _navigated = false;

  @override
  void onInit() {
    super.onInit();

    // 3 Second Animation setup (0.0 to 1.0)
    loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    loadingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: loadingController,
        curve: Curves.linear,
      ),
    );

    // Dynamic dot switching based on progress values
    loadingAnimation.addListener(() {
      final progress = loadingAnimation.value;
      if (progress < 0.25) {
        activeDot.value = 0;
      } else if (progress < 0.50) {
        activeDot.value = 1;
      } else if (progress < 0.75) {
        activeDot.value = 2;
      } else {
        activeDot.value = 3;
      }
    });

    // Start 3-second progress
    loadingController.forward();

    // Auto navigate after completion
    loadingController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _navigateToHome();
      }
    });
  }

  void _navigateToHome() {
    if (isClosed || _navigated) return;
    _navigated = true;
    Get.offAllNamed(AppRoutes.home);
  }

  @override
  void onClose() {
    loadingController.dispose();
    super.onClose();
  }
}