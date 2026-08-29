import 'package:dice_app/feature/achievement/controller/achivement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';


class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AchievementController());

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('ACHIEVEMENTS', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Obx(
        () => ListView.separated(
          padding: const EdgeInsets.all(20),
          itemCount: controller.achievements.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = controller.achievements[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: CustomColors.surface,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: item.isCompleted ? CustomColors.accentGreen.withOpacity(0.4) : Colors.transparent,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: CustomColors.surfaceLight,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.star_rounded,
                      color: item.isCompleted ? Colors.amber : CustomColors.textSecondary,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.title,
                          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          item.description,
                          style: const TextStyle(color: CustomColors.textSecondary, fontSize: 12),
                        ),
                        if (!item.isCompleted) ...[
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: item.currentProgress / item.totalProgress,
                            backgroundColor: CustomColors.surfaceLight,
                            color: CustomColors.primaryNeon,
                          ),
                        ]
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  item.isCompleted
                      ? const Icon(Icons.check_circle_rounded, color: CustomColors.accentGreen)
                      : Text(
                          '${item.currentProgress}/${item.totalProgress}',
                          style: const TextStyle(color: CustomColors.textSecondary, fontSize: 12),
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}