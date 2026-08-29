import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:dice_app/history/model/history_model.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';
import '../../../core/widgets/custom_card.dart';


class HistoryCard extends StatelessWidget {
  final RollHistoryItem item;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const HistoryCard({
    Key? key,
    required this.item,
    this.onDelete,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.cardBgLight,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Dice info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${item.diceCount}D${item.diceSides}',
                  style: AppTextStyles.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  item.timeFormatted,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          // Results display
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                if (item.diceCount <= 3)
                  Row(
                    children: item.results
                        .map(
                          (result) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryPurple.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '$result',
                              style: AppTextStyles.labelSmall,
                            ),
                          ),
                        )
                        .toList(),
                  )
                else
                  Text(
                    '+${item.diceCount}',
                    style: AppTextStyles.labelMedium.copyWith(
                      color: AppColors.primaryPurple,
                    ),
                  ),
              ],
            ),
          ),
          // Total result
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '${item.total}',
              style: AppTextStyles.headingSmall.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
          // Delete button
          if (onDelete != null)
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: GestureDetector(
                onTap: onDelete,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 16,
                    color: AppColors.error,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}