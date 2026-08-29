import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';
import '../../../core/widgets/custom_card.dart';

class DiceSettingsPreview extends StatelessWidget {
  final int diceCount;
  final int diceSides;
  final String selectedColor;
  final double animationSpeed;
  final VoidCallback onTap;

  const DiceSettingsPreview({
    Key? key,
    required this.diceCount,
    required this.diceSides,
    required this.selectedColor,
    required this.animationSpeed,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.cardBgLight,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$diceCount Dice × $diceSides Sides',
                style: AppTextStyles.labelLarge,
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryPurple.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      selectedColor,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primaryPurple,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Speed: ${(animationSpeed * 100).toInt()}%',
                    style: AppTextStyles.bodySmall,
                  ),
                ],
              ),
            ],
          ),
          Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }
}