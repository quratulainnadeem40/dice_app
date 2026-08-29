import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';
import '../../../core/widgets/custom_card.dart';

class TotalResultCard extends StatelessWidget {
  final int total;
  final List<int> results;
  final String label;

  const TotalResultCard({
    Key? key,
    required this.total,
    required this.results,
    this.label = 'Total',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const SizedBox.shrink();
    }

    return CustomCard(
      backgroundColor: AppColors.cardBgLight,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last Result',
                style: AppTextStyles.bodySmall,
              ),
              const SizedBox(height: 4),
              Text(
                '$total',
                style: AppTextStyles.diceResultText.copyWith(
                  fontSize: 48,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.primaryPurple),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Total',
                  style: AppTextStyles.labelSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  '$total',
                  style: AppTextStyles.headingMedium.copyWith(
                    color: AppColors.primaryPurple,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}