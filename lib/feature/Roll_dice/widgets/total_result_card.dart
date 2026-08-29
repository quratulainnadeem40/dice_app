import 'package:flutter/material.dart';

class TotalResultCard extends StatelessWidget {
  final int total;

  const TotalResultCard({
    Key? key,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF8B5CF6).withOpacity(0.3)),
      ),
      child: Column(
        children: [
          const Text(
            'TOTAL SCORE',
            style: TextStyle(color: Colors.white54, fontSize: 12, letterSpacing: 1.2),
          ),
          const SizedBox(height: 4),
          Text(
            '$total',
            style: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}