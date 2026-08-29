import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/colors_custom.dart';
import '../../../core/widgets/custom_card.dart';

class QuickActions extends StatelessWidget {
  final VoidCallback onMultiplayer;
  final VoidCallback onHistory;
  final VoidCallback onAchievements;

  const QuickActions({
    Key? key,
    required this.onMultiplayer,
    required this.onHistory,
    required this.onAchievements,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          // Multiplayer
          _buildActionButton(
            icon: Icons.people_rounded,
            title: 'Multiplayer',
            subtitle: 'Play with friends',
            onTap: onMultiplayer,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildSmallActionButton(
                  icon: Icons.history_rounded,
                  title: 'History',
                  onTap: onHistory,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildSmallActionButton(
                  icon: Icons.emoji_events_rounded,
                  title: 'Achievements',
                  onTap: onAchievements,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return CustomCard(
      backgroundColor: AppColors.cardBgLight,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryPurple,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.labelLarge,
                ),
                Text(
                  subtitle,
                  style: AppTextStyles.bodySmall,
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_rounded,
            color: AppColors.textSecondary,
          ),
        ],
      ),
    );
  }

  Widget _buildSmallActionButton({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return CustomCard(
      backgroundColor: AppColors.cardBgLight,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryPurple.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              color: AppColors.primaryPurple,
              size: 20,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: AppTextStyles.labelSmall,
          ),
        ],
      ),
    );
  }
}