import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';


class HomeHeader extends StatelessWidget {
  final VoidCallback? onSettingsTap;

  const HomeHeader({
    Key? key,
    this.onSettingsTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Title
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'DICE ROLLER',
                style: AppTextStyles.headingMedium.copyWith(
                  color: AppColors.primaryPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          // Settings Icon
          GestureDetector(
            onTap: onSettingsTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderColor),
              ),
              child: const Icon(
                Icons.settings_rounded,
                color: AppColors.textPrimary,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}