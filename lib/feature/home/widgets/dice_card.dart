import 'package:dice_app/feature/Roll_dice/model/roll_dice_model.dart';
import 'package:flutter/material.dart';
import 'package:dice_app/core/theme/colors_custom.dart';


class DiceCard extends StatelessWidget {
  final DiceModel dice;
  final VoidCallback? onTap;

  const DiceCard({
    Key? key,
    required this.dice,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: ColorsCustom.cardBg,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white10),
          boxShadow: [
            BoxShadow(
              color: dice.color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: dice.color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  '${dice.currentValue}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'D${dice.sides}',
              style: const TextStyle(
                color: ColorsCustom.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}