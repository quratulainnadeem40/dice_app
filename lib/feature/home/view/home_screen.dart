import 'package:dice_app/feature/home/widgets/quick_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';
import '../../../core/widgets/section_title.dart';
import '../controller/home_controller.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_roll_card.dart';
import '../widgets/recent_roll_card.dart';
import '../widgets/home_stat_card.dart';
import '../widgets/achievement_preview.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              HomeHeader(
                onSettingsTap: () {
                  Get.toNamed('/settings');
                },
              ),
              const SizedBox(height: 16),

              // Quick Roll Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => QuickRollCard(
                    lastResult: controller.stats.value.lastResult,
                    diceCount: 1,
                    diceSides: 6,
                    onTap: controller.goToRoll,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Stats Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: HomeStatCard(
                        label: 'Total Rolls',
                        value: '15',
                        icon: Icons.casino_rounded,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: HomeStatCard(
                        label: 'Max Roll',
                        value: '6',
                        icon: Icons.trending_up_rounded,
                        iconColor: AppColors.success,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: HomeStatCard(
                        label: 'Min Roll',
                        value: '1',
                        icon: Icons.trending_down_rounded,
                        iconColor: AppColors.error,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Quick Actions
              QuickActions(
                onMultiplayer: controller.goToMultiplayer,
                onHistory: controller.goToHistory,
                onAchievements: controller.goToAchievements,
              ),
              const SizedBox(height: 24),

              // Recent Rolls Section
              SectionTitle(
                title: 'Recent Rolls',
                subtitle: 'Your last 5 rolls',
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => Column(
                    children: controller.recentRolls
                        .take(5)
                        .map((roll) => Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: RecentRollCard(roll: roll),
                            ))
                        .toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Achievements Section
              Obx(
                () => AchievementPreview(
                  achievements: controller.achievements,
                  onSeeAll: controller.goToAchievements,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}