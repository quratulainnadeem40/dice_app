import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  final RxInt activeDot = 0.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.15,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    fadeAnimation = Tween<double>(
      begin: 0.35,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    _startLoadingDots();
    _startSplashTimer();
  }

  void _startLoadingDots() {
    Timer.periodic(
      const Duration(milliseconds: 350),
      (timer) {
        if (isClosed) {
          timer.cancel();
          return;
        }

        activeDot.value = (activeDot.value + 1) % 4;
      },
    );
  }

  void _startSplashTimer() {
    _timer = Timer(
      const Duration(seconds: 2),
      () {
        Get.offNamed(AppRoutes.home);
      },
    );
  }

  @override
  void onClose() {
    _timer?.cancel();
    animationController.dispose();
    super.onClose();
  }
}