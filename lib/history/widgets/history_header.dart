import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';

import '../../../core/widgets/custom_card.dart';

class HistoryHeader extends StatelessWidget {
  final int totalRolls;
  final double averageRoll;
  final int maxRoll;
  final int minRoll;

  const HistoryHeader({
    Key? key,
    required this.totalRolls,
    required this.averageRoll,
    required this.maxRoll,
    required this.minRoll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Main stats
        Row(
          children: [
            Expanded(
              child: CustomCard(
                backgroundColor: AppColors.cardBgLight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.casino_rounded,
                      color: AppColors.primaryPurple,
                      size: 18,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$totalRolls',
                      style: AppTextStyles.headingSmall,
                    ),
                    Text(
                      'Total',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomCard(
                backgroundColor: AppColors.cardBgLight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calculate_rounded,
                      color: AppColors.success,
                      size: 18,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      averageRoll.toStringAsFixed(1),
                      style: AppTextStyles.headingSmall,
                    ),
                    Text(
                      'Average',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomCard(
                backgroundColor: AppColors.cardBgLight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.trending_up_rounded,
                      color: AppColors.warning,
                      size: 18,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$maxRoll',
                      style: AppTextStyles.headingSmall,
                    ),
                    Text(
                      'Max',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: CustomCard(
                backgroundColor: AppColors.cardBgLight,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.trending_down_rounded,
                      color: AppColors.error,
                      size: 18,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$minRoll',
                      style: AppTextStyles.headingSmall,
                    ),
                    Text(
                      'Min',
                      style: AppTextStyles.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}