import 'package:flutter/material.dart';
import '../model/achievement_model.dart';
import 'achievement_badge.dart';

class AchievementCard extends StatelessWidget {
  final AchievementModel achievement;

  const AchievementCard({
    Key? key,
    required this.achievement,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: achievement.isUnlocked ? const Color(0xFF8B5CF6).withOpacity(0.4) : Colors.white10,
        ),
      ),
      child: Row(
        children: [
          AchievementBadge(icon: achievement.icon, isUnlocked: achievement.isUnlocked),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  achievement.title,
                  style: TextStyle(
                    color: achievement.isUnlocked ? Colors.white : Colors.white54,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  achievement.description,
                  style: const TextStyle(color: Colors.white38, fontSize: 12),
                ),
                const SizedBox(height: 8),
                if (!achievement.isUnlocked)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: achievement.progressPercentage,
                      minHeight: 4,
                      backgroundColor: Colors.white10,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF8B5CF6)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}