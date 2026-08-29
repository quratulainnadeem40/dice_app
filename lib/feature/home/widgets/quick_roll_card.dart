import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';

import '../../../core/widgets/custom_card.dart';

class QuickRollCard extends StatelessWidget {
  final int lastResult;
  final int diceCount;
  final int diceSides;
  final VoidCallback onTap;

  const QuickRollCard({
    Key? key,
    required this.lastResult,
    required this.diceCount,
    required this.diceSides,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GradientCard(
      colors: [
        AppColors.primaryPurple.withOpacity(0.8),
        AppColors.primaryPurpleLight.withOpacity(0.8),
      ],
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'TAP THE DICE TO ROLL',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textPrimary,
                  letterSpacing: 1,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.textPrimary.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'D$diceSides',
                  style: AppTextStyles.labelSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Large Dice
          Text(
            '🎲',
            style: const TextStyle(fontSize: 80),
          ),
          const SizedBox(height: 32),
          // Stats
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last Result',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$lastResult',
                    style: AppTextStyles.headingLarge,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Total Rolls',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondary.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '15',
                    style: AppTextStyles.headingLarge,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}