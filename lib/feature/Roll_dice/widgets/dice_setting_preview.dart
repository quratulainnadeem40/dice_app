import 'package:flutter/material.dart';

class DiceSettingsPreview extends StatelessWidget {
  final int diceCount;
  final int sides;

  const DiceSettingsPreview({
    Key? key,
    required this.diceCount,
    required this.sides,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Chip(
          backgroundColor: const Color(0xFF1E1A34),
          label: Text('Dice: $diceCount', style: const TextStyle(color: Colors.white70)),
        ),
        const SizedBox(width: 8),
        Chip(
          backgroundColor: const Color(0xFF1E1A34),
          label: Text('Sides: D$sides', style: const TextStyle(color: Colors.white70)),
        ),
      ],
    );
  }
}