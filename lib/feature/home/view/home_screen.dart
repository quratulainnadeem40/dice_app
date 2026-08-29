import 'package:dice_app/feature/home/widgets/quick_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
      backgroundColor: const Color(0xFF0F0B1E),
      body: SafeArea(
        child: Obx(() {
          final data = controller.homeData.value;
          if (data == null) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF8B5CF6)));
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            children: [
              HomeHeader(userName: data.userName),
              const SizedBox(height: 20),
              QuickRollCard(onTap: controller.goToRollScreen),
              const SizedBox(height: 24),
              const QuickActions(),
              const SizedBox(height: 24),
              RecentRollCard(
                lastResult: data.lastRollResult,
                onTap: controller.goToHistoryScreen,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: HomeStatCard(title: 'Total Rolls', value: '${data.totalRolls}'),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: HomeStatCard(title: 'Last Roll', value: '${data.lastRollResult}'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              AchievementPreview(title: data.recentAchievement),
            ],
          );
        }),
      ),
    );
  }
}