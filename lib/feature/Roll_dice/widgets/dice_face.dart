// import 'package:flutter/material.dart';

// class DiceFace extends StatelessWidget {
//   final int value;
//   final Color color;

//   const DiceFace({
//     Key? key,
//     required this.value,
//     required this.color,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 85,
//       height: 85,
//       padding: const EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(18),
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             color.withOpacity(0.95),
//             color,
//             Colors.black.withOpacity(0.45), // 3D bevel depth effect
//           ],
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: color.withOpacity(0.5),
//             blurRadius: 14,
//             spreadRadius: 2,
//             offset: const Offset(0, 6), // Outer glow
//           ),
//         ],
//       ),
//       child: _buildDiceDots(value),
//     );
//   }

//   // Pure image jaisi dots (pips) render karne ke liye layout helper
//   Widget _buildDiceDots(int dotValue) {
//     List<bool> dots = List.filled(9, false);

//     switch (dotValue) {
//       case 1:
//         dots[4] = true;
//         break;
//       case 2:
//         dots[0] = dots[8] = true;
//         break;
//       case 3:
//         dots[0] = dots[4] = dots[8] = true;
//         break;
//       case 4:
//         dots[0] = dots[2] = dots[6] = dots[8] = true;
//         break;
//       case 5:
//         dots[0] = dots[2] = dots[4] = dots[6] = dots[8] = true;
//         break;
//       case 6:
//         dots[0] = dots[2] = dots[3] = dots[5] = dots[6] = dots[8] = true;
//         break;
//       default:
//         dots[4] = true;
//     }

//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         crossAxisSpacing: 4,
//         mainAxisSpacing: 4,
//       ),
//       itemCount: 9,
//       itemBuilder: (context, index) {
//         return dots[index]
//             ? Container(
//                 decoration: const BoxDecoration(
//                   color: Colors.white, // White 3D dots
//                   shape: BoxShape.circle,
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black26,
//                       blurRadius: 2,
//                       offset: Offset(0, 1),
//                     )
//                   ],
//                 ),
//               )
//             : const SizedBox.shrink();
//       },
//     );
//   }
// }
import 'package:flutter/material.dart';

class DiceFace extends StatelessWidget {
  final int value;
  final Color baseColor;

  const DiceFace({Key? key, required this.value, required this.baseColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            baseColor.withOpacity(0.9),
            baseColor.withOpacity(0.5),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: baseColor.withOpacity(0.6),
            blurRadius: 18,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.3), width: 1.5),
      ),
      child: Center(
        child: Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.bold,
            shadows: [Shadow(color: Colors.black45, blurRadius: 6)],
          ),
        ),
      ),
    );
  }
}