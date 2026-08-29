// import 'dart:ui';
// import 'package:flutter/material.dart';

// class HomeStatCard extends StatelessWidget {
//   final String title;
//   final String value;

//   const HomeStatCard({
//     Key? key,
//     required this.title,
//     required this.value,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//       borderRadius: BorderRadius.circular(18),
//       child: BackdropFilter(
//         filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
//         child: Container(
//           padding: const EdgeInsets.all(18),
//           decoration: BoxDecoration(
//             color: const Color(0xFF1E1938).withOpacity(0.4),
//             borderRadius: BorderRadius.circular(18),
//             border: Border.all(
//               color: const Color(0xFF8B5CF6).withOpacity(0.2),
//               width: 1.2,
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: const Color(0xFF8B5CF6).withOpacity(0.04),
//                 blurRadius: 10,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   color: Color(0xFFA78BFA),
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 value,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 24,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 0.5,
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

class HomeStatCard extends StatelessWidget {
  final String title;
  final String value;

  const HomeStatCard({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1B2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}