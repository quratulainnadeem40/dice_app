import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;

  late Animation<double> scaleAnimation;
  late Animation<double> fadeAnimation;

  final RxInt activeDot = 0.obs;

  Timer? _dotTimer;

  @override
  void onInit() {
    super.onInit();

    // Loading animation
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
  }

  void _startLoadingDots() {
    _dotTimer = Timer.periodic(
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

  @override
  void onClose() {
    _dotTimer?.cancel();
    animationController.dispose();

    super.onClose();
  }
}