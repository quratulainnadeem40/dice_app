// import 'package:flutter/material.dart';

// class DiceResult extends StatelessWidget {
//   final int result;

//   const DiceResult({
//     Key? key,
//     required this.result,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E1A34),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           const Icon(Icons.casino_outlined, color: Colors.white54, size: 20),
//           const SizedBox(width: 8),
//           Text(
//             'Result: $result',
//             style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../model/roll_dice_model.dart';

class DiceResultWidget extends StatelessWidget {
  final List<DiceModel> diceList;

  const DiceResultWidget({Key? key, required this.diceList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 0; i < diceList.length; i++) ...[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: diceList[i].color.withOpacity(0.8),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: diceList[i].color.withOpacity(0.5),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Text(
              '${diceList[i].currentValue}',
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          if (i < diceList.length - 1)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text('+', style: TextStyle(color: Colors.white70, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
        ],
      ],
    );
  }
}