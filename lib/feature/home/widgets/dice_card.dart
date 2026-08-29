import 'dart:ui';
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1E1938).withOpacity(0.4),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: dice.color.withOpacity(0.3),
                width: 1.5,
              ),
              boxShadow: [
                BoxShadow(
                  color: dice.color.withOpacity(0.15),
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Glowing Central Dice Display
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: dice.color,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: dice.color.withOpacity(0.6),
                        blurRadius: 20,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${dice.currentValue}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'D${dice.sides}',
                  style: const TextStyle(
                    color: Color(0xFFA78BFA),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}