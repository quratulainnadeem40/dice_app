// import 'package:flutter/material.dart';

// class TotalResultCard extends StatelessWidget {
//   final int total;

//   const TotalResultCard({
//     Key? key,
//     required this.total,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.symmetric(vertical: 20),
//       decoration: BoxDecoration(
//         color: const Color(0xFF1E1A34),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
//       ),
//       child: Column(
//         children: [
//           const Text(
//             'TOTAL SCORE',
//             style: TextStyle(color: Colors.white54, fontSize: 12, letterSpacing: 1.2),
//           ),
//           const SizedBox(height: 4),
//           Text(
//             '$total',
//             style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:ui';
import 'package:flutter/material.dart';

class TotalResultCard extends StatelessWidget {
  final int totalScore;

  const TotalResultCard({Key? key, required this.totalScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 22),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.14)),
          ),
          child: Column(
            children: [
              const Text(
                'TOTAL SCORE',
                style: TextStyle(
                  color: Colors.white38,
                  fontSize: 12,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Colors.white, Color(0xFF93C5FD)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ).createShader(bounds),
                child: Text(
                  '$totalScore',
                  style: const TextStyle(
                    fontSize: 46,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}