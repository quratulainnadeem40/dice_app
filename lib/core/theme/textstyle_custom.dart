import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:flutter/material.dart';


class AppTextStyles {
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
}