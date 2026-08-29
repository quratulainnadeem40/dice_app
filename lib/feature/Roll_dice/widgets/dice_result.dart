import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';

import 'dice_face.dart';

class DiceResult extends StatelessWidget {
  final List<int> results;
  final Color diceColor;
  final bool showAnimations;

  const DiceResult({
    Key? key,
    required this.results,
    required this.diceColor,
    this.showAnimations = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (results.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        // Individual dice
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          runSpacing: 12,
          children: List.generate(
            results.length,
            (index) => DiceFace(
              number: results[index],
              color: diceColor,
              isAnimating: showAnimations,
              size: 80,
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Result breakdown
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardBgLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              results.length > 1 ? results.length + 2 : 1,
              (index) {
                if (index < results.length) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Dice ${index + 1}',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${results[index]}',
                        style: AppTextStyles.headingSmall,
                      ),
                    ],
                  );
                } else if (index == results.length) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${results.reduce((a, b) => a + b)}',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: AppColors.primaryPurple,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Average',
                        style: AppTextStyles.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${(results.reduce((a, b) => a + b) / results.length).toStringAsFixed(1)}',
                        style: AppTextStyles.headingSmall.copyWith(
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}