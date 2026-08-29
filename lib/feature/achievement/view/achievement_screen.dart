import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';
import '../model/achievement_model.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<AchievementModel> achievements = [
      AchievementModel(title: 'First Roll', description: 'Roll dice for the first time', currentProgress: 1, totalProgress: 1, isCompleted: true),
      AchievementModel(title: 'Rolling Star', description: 'Roll 100 times', currentProgress: 75, totalProgress: 100, isCompleted: false),
      AchievementModel(title: 'Lucky Roller', description: 'Get a total of 100', currentProgress: 100, totalProgress: 100, isCompleted: true),
      AchievementModel(title: 'Dice Master', description: 'Roll 6 dice together', currentProgress: 2, totalProgress: 10, isCompleted: false),
      AchievementModel(title: 'Streak King', description: 'Roll 5 times in a row', currentProgress: 5, totalProgress: 5, isCompleted: true),
    ];

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('ACHIEVEMENTS', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: achievements.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = achievements[index];
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: CustomColors.surface,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.stars_rounded,
                  size: 36,
                  color: item.isCompleted ? Colors.amber : CustomColors.textSecondary,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      const SizedBox(height: 2),
                      Text(item.description, style: const TextStyle(color: CustomColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                item.isCompleted
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: CustomColors.accentGreen.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: CustomColors.accentGreen),
                        ),
                        child: const Text('Completed', style: TextStyle(color: CustomColors.accentGreen, fontSize: 10, fontWeight: FontWeight.bold)),
                      )
                    : Text('${item.currentProgress}/${item.totalProgress}', style: const TextStyle(color: CustomColors.textSecondary, fontSize: 12)),
              ],
            ),
          );
        },
      ),
    );
  }
}