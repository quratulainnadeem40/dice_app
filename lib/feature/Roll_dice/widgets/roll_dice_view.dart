import 'package:flutter/material.dart';
// Replace with your actual import path
import '../widgets/dice_widget.dart'; 

class RollDiceView extends StatelessWidget {
  // Pre-defined separate colors like the image (Purple, Blue, Orange, Green, Red)
  final List<Color> diceColors = const [
    Color(0xFF8A2BE2), // Purple
    Color(0xFF1E90FF), // Blue
    Color(0xFFFF8C00), // Orange
    Color(0xFF32CD32), // Green
    Color(0xFFFF4500), // Red
    Color(0xFFFFD700), // Yellow
  ];

  final List<int> currentDiceValues = [4, 5, 6, 2, 3]; // Example rolled values

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C20), // Dark theme background
      body: Center(
        child: Wrap(
          alignment: WrapAlignment.center,
          spacing: 10,
          runSpacing: 10,
          children: List.generate(currentDiceValues.length, (index) {
            return CustomDiceWidget(
              value: currentDiceValues[index],
              baseColor: diceColors[index % diceColors.length], // Assigning separate colors
            );
          }),
        ),
      ),
    );
  }
}