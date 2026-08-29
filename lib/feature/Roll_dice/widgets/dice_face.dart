import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';

class DiceFace extends StatelessWidget {
  final int number;
  final Color? color;
  final bool isAnimating;
  final double size;

  const DiceFace({
    Key? key,
    required this.number,
    this.color,
    this.isAnimating = false,
    this.size = 100,
  }) : super(key: key);

  Color get diceColor {
    return color ?? AppColors.dicePurple;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: isAnimating ? 1.1 : 1.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: diceColor,
          borderRadius: BorderRadius.circular(size * 0.15),
          boxShadow: [
            BoxShadow(
              color: diceColor.withOpacity(0.5),
              blurRadius: 12,
              spreadRadius: 2,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          gradient: LinearGradient(
            colors: [
              diceColor,
              diceColor.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Text(
            '$number',
            style: TextStyle(
              fontSize: size * 0.4,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.3),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}