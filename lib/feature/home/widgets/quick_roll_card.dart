// import 'dart:ui';
// import 'package:flutter/material.dart';

// class QuickRollCard extends StatelessWidget {
//   final VoidCallback onTap;

//   const QuickRollCard({Key? key, required this.onTap}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(24),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//         child: Container(
//           padding: const EdgeInsets.all(20),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E1938).withOpacity(0.5),
//             borderRadius: BorderRadius.circular(24),
//             border: Border.all(
//               color: const Color(0xFF8B5CF6).withOpacity(0.2),
//               width: 1.5,
//             ),
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Row(
//                 children: const [
//                   Icon(Icons.auto_awesome, color: Color(0xFFA78BFA), size: 16),
//                   SizedBox(width: 8),
//                   Text(
//                     'YOUR NEXT ROLL',
//                     style: TextStyle(
//                       color: Color(0xFFA78BFA),
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       letterSpacing: 1.2,
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
              
//               // Glow Dice Container
//               Center(
//                 child: Container(
//                   height: 100,
//                   width: 100,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF8B5CF6),
//                     borderRadius: BorderRadius.circular(24),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF8B5CF6).withOpacity(0.6),
//                         blurRadius: 30,
//                         spreadRadius: 2,
//                       ),
//                     ],
//                   ),
//                   child: const Center(
//                     child: Icon(
//                       Icons.casino_rounded,
//                       size: 56,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),

//               // Neon Action Button
//               GestureDetector(
//                 onTap: onTap,
//                 child: Container(
//                   width: double.infinity,
//                   height: 52,
//                   decoration: BoxDecoration(
//                     gradient: const LinearGradient(
//                       colors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
//                     ),
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: const Color(0xFF8B5CF6).withOpacity(0.4),
//                         blurRadius: 15,
//                         offset: const Offset(0, 4),
//                       ),
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.grid_view_rounded, color: Colors.white, size: 20),
//                       SizedBox(width: 8),
//                       Text(
//                         'ROLL DICE',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 15,
//                           letterSpacing: 0.5,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class QuickRollCard extends StatelessWidget {
  final VoidCallback onRoll;
  const QuickRollCard({Key? key, required this.onRoll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2A1B4E).withOpacity(0.6),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.purpleAccent.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Row(
            children: const [
              Icon(Icons.auto_awesome, color: Colors.purpleAccent, size: 16),
              SizedBox(width: 8),
              Text('NEXT ROLL', style: TextStyle(color: Colors.white54, fontSize: 12, letterSpacing: 1.2)),
            ],
          ),
          const SizedBox(height: 20),
          const Icon(Icons.casino, size: 80, color: Colors.purpleAccent),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: onRoll,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF7C3AED),
              minimumSize: const Size(double.infinity, 48),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.casino, color: Colors.white),
            label: const Text('ROLL DICE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}