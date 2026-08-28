import 'package:flutter/material.dart';
import 'package:dice_app/core/theme/colors_custom.dart';

class AppTextStyles {
  // Splash
  static const TextStyle title = TextStyle(
    fontSize: 54,
    fontWeight: FontWeight.w800,
    letterSpacing: 3,
    color: AppColors.white,
  );

  static const TextStyle appName = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 12,
    color: AppColors.blue,
  );

  static const TextStyle tagline = TextStyle(
    fontSize: 16,
    color: AppColors.lightText,
  );

  static const TextStyle loading = TextStyle(
    color: AppColors.violet,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 6,
  );

  // Home
  static const TextStyle homeGreeting = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.lightText,
  );

  static const TextStyle homeHeading = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
    letterSpacing: 0.2,
  );

  static const TextStyle cardTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );

  static const TextStyle cardDescription = TextStyle(
    fontSize: 13,
    height: 1.5,
    color: AppColors.lightText,
  );

  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static const TextStyle sectionTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
    color: AppColors.lightText,
  );

  static const TextStyle quickAction = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle recentTitle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static const TextStyle recentValue = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: AppColors.blue,
  );
}