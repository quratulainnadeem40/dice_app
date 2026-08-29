// import 'dart:ui';
// import 'package:flutter/material.dart';

// class QuickActions extends StatelessWidget {
//   const QuickActions({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Quick Actions',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18,
//             fontWeight: FontWeight.bold,
//             letterSpacing: 0.5,
//           ),
//         ),
//         const SizedBox(height: 14),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(child: _buildActionButton(Icons.groups_rounded, 'Players')),
//             const SizedBox(width: 12),
//             Expanded(child: _buildActionButton(Icons.emoji_events_rounded, 'Scores')),
//             const SizedBox(width: 12),
//             Expanded(child: _buildActionButton(Icons.insights_rounded, 'Stats')),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildActionButton(IconData icon, String label) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.symmetric(vertical: 18),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E1938).withOpacity(0.4),
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: const Color(0xFF8B5CF6).withOpacity(0.25),
//               width: 1.2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF8B5CF6).withOpacity(0.05),
//                 blurRadius: 10,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               // Glowing Icon Container
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: const Color(0xFF8B5CF6).withOpacity(0.15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: const Color(0xFF8B5CF6).withOpacity(0.3),
//                       blurRadius: 12,
//                       spreadRadius: -2,
//                     ),
//                   ],
//                 ),
//                 child: Icon(
//                   icon,
//                   color: const Color(0xFFA78BFA),
//                   size: 24,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 label,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 13,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 0.3,
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

class QuickActions extends StatelessWidget {
  const QuickActions({Key? key}) : super(key: key);

  Widget _buildActionButton(IconData icon, String label) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B2E),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.purpleAccent),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Actions', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildActionButton(Icons.people, 'Players'),
            _buildActionButton(Icons.emoji_events, 'Scores'),
            _buildActionButton(Icons.bar_chart, 'Stats'),
          ],
        ),
      ],
    );
  }
}