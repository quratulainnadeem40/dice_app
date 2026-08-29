// import 'package:flutter/material.dart';

// class DiceSettingsPreview extends StatelessWidget {
//   final int diceCount;
//   final int sides;

//   const DiceSettingsPreview({
//     Key? key,
//     required this.diceCount,
//     required this.sides,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Chip(
//           backgroundColor: const Color(0xFF1E1A34),
//           label: Text('Dice: $diceCount', style: const TextStyle(color: Colors.white70)),
//         ),
//         const SizedBox(width: 8),
//         Chip(
//           backgroundColor: const Color(0xFF1E1A34),
//           label: Text('Sides: D$sides', style: const TextStyle(color: Colors.white70)),
//         ),
//       ],
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';

class DiceSettingsPreview extends StatelessWidget {
  final String label;

  const DiceSettingsPreview({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Text(
            label,
            style: const TextStyle(color: Colors.white70, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}