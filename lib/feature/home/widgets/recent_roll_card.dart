import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/colors_custom.dart';

import '../../../core/widgets/custom_card.dart';
import '../model/home_model.dart';

class RecentRollCard extends StatelessWidget {
  final RecentRoll roll;

  const RecentRollCard({
    Key? key,
    required this.roll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm').format(roll.timestamp);
    
    return CustomCard(
      backgroundColor: AppColors.cardBgLight,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${roll.diceCount} Dice × ${roll.diceSides} Sides',
                  style: AppTextStyles.labelMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  timeFormat,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${roll.result}',
              style: AppTextStyles.headingSmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}