import 'package:dice_app/feature/Roll_dice/model/roll_dice_model.dart';
import 'package:flutter/material.dart';

import 'dice_face.dart';

class DiceCard extends StatelessWidget {
  final DiceModel dice;

  const DiceCard({
    Key? key,
    required this.dice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DiceFace(value: dice.currentValue, color: dice.color),
          const SizedBox(height: 8),
          Text(
            'D${dice.sides}',
            style: const TextStyle(color: Colors.white54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}