// import 'dart:ui';
// import 'package:flutter/material.dart';

// class AchievementPreview extends StatelessWidget {
//   final String title;

//   const AchievementPreview({
//     Key? key,
//     required this.title,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E1938).withOpacity(0.4),
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: const Color(0xFF8B5CF6).withOpacity(0.3),
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
//           child: Row(
//             children: [
//               // Glowing Trophy/Star Badge
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.amber.withOpacity(0.15),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.amber.withOpacity(0.3),
//                       blurRadius: 12,
//                       spreadRadius: -2,
//                     ),
//                   ],
//                 ),
//                 child: const Icon(
//                   Icons.stars_rounded,
//                   color: Colors.amber,
//                   size: 26,
//                 ),
//               ),
//               const SizedBox(width: 14),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       'RECENT ACHIEVEMENT',
//                       style: TextStyle(
//                         color: Color(0xFFA78BFA),
//                         fontSize: 11,
//                         fontWeight: FontWeight.bold,
//                         letterSpacing: 0.8,
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
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

class AchievementPreview extends StatelessWidget {
  const AchievementPreview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.purple.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: const [
          Icon(Icons.emoji_events, color: Colors.amber),
          SizedBox(width: 8),
          Text('Achievement Unlocked!', style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}