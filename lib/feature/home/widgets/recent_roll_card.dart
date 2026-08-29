// import 'dart:ui';
// import 'package:flutter/material.dart';

// class RecentRollCard extends StatelessWidget {
//   final int lastResult;
//   final VoidCallback onTap;

//   const RecentRollCard({
//     Key? key,
//     required this.lastResult,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(18),
//         child: BackdropFilter(
//           filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
//             decoration: BoxDecoration(
//               color: const Color(0xFF1E1938).withOpacity(0.4),
//               borderRadius: BorderRadius.circular(18),
//               // Cyan/Blue subtle glowing border highlight
//               border: Border.all(
//                 color: const Color(0xFF38BDF8).withOpacity(0.4),
//                 width: 1.5,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: const Color(0xFF38BDF8).withOpacity(0.1),
//                   blurRadius: 15,
//                   spreadRadius: 0,
//                 ),
//               ],
//             ),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: const [
//                     Text(
//                       'Last Result',
//                       style: TextStyle(
//                         color: Color(0xFF94A3B8),
//                         fontSize: 12,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     SizedBox(height: 4),
//                     Text(
//                       'Tap to view history',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   '$lastResult',
//                   style: const TextStyle(
//                     color: Color(0xFF38BDF8),
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     shadows: [
//                       Shadow(
//                         color: Color(0xFF38BDF8),
//                         blurRadius: 10,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class RecentRollCard extends StatelessWidget {
  final int lastResult;
  const RecentRollCard({Key? key, required this.lastResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Last Result', style: TextStyle(color: Colors.white54, fontSize: 12)),
              SizedBox(height: 4),
              Text('Tap to view history', style: TextStyle(color: Colors.white, fontSize: 14)),
            ],
          ),
          Text('$lastResult', style: const TextStyle(color: Colors.cyanAccent, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}