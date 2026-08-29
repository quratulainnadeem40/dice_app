import 'package:dice_app/feature/achievement/controller/achivement_controller.dart';
import 'package:dice_app/feature/achievement/widget/achievemnet_card.dart';
import 'package:dice_app/feature/achievement/widget/achivement_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AchievementScreen extends GetView<AchievementController> {
  const AchievementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0B1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('ACHIEVEMENTS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Obx(() => AchievementProgress(
                    unlockedCount: controller.unlockedCount,
                    totalCount: controller.achievements.length,
                  )),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() => ListView.separated(
                      itemCount: controller.achievements.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        return AchievementCard(achievement: controller.achievements[index]);
                      },
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}