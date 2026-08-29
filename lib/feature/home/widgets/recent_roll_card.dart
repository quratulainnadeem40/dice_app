import 'package:flutter/material.dart';

class RecentRollCard extends StatelessWidget {
  final int lastResult;
  final VoidCallback onTap;

  const RecentRollCard({
    Key? key,
    required this.lastResult,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1E1A34),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Last Result', style: TextStyle(color: Colors.white54, fontSize: 12)),
                SizedBox(height: 4),
                Text('Tap to view history', style: TextStyle(color: Colors.white, fontSize: 14)),
              ],
            ),
            Text(
              '$lastResult',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}