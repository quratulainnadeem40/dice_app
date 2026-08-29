import 'package:flutter/material.dart';



class AchievementProgress extends StatelessWidget {
  final int unlockedCount;
  final int totalCount;

  const AchievementProgress({
    Key? key,
    required this.unlockedCount,
    required this.totalCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double percentage = totalCount > 0 ? unlockedCount / totalCount : 0.0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Overall Progress',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                '$unlockedCount / $totalCount Unlocked',
                style: const TextStyle(color: Color(0xFF8B5CF6), fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
            ),
          ),
        ],
      ),
    );
  }
}