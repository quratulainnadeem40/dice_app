import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';
import '../../../core/widgets/custom_card.dart';
import '../model/home_model.dart';

class AchievementPreview extends StatelessWidget {
  final List<Achievement> achievements;
  final VoidCallback onSeeAll;

  const AchievementPreview({
    Key? key,
    required this.achievements,
    required this.onSeeAll,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Achievements',
                style: AppTextStyles.headingSmall,
              ),
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'See All',
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.primaryPurple,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: achievements.length,
            itemBuilder: (context, index) {
              final achievement = achievements[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: _buildAchievementBadge(achievement),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildAchievementBadge(Achievement achievement) {
    return CustomCard(
      backgroundColor: achievement.isUnlocked
          ? AppColors.cardBgLight
          : AppColors.cardBg.withOpacity(0.5),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Opacity(
            opacity: achievement.isUnlocked ? 1.0 : 0.5,
            child: Text(
              achievement.icon,
              style: const TextStyle(fontSize: 32),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 70,
            child: Text(
              achievement.title,
              style: AppTextStyles.labelSmall,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!achievement.isUnlocked)
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                '${(achievement.progress * 100).toInt()}%',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primaryPurple,
                ),
              ),
            ),
        ],
      ),
    );
  }
}