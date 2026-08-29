import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';
import '../controller/multiplayer_controller.dart';

class MultiplayerScreen extends StatelessWidget {
  const MultiplayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MultiplayerController());

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('MULTIPLAYER', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Mode Switcher (Local / Online)
            Obx(
              () => Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: CustomColors.surface,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildTabButton('LOCAL', controller.selectedTab.value == 0, () {
                        controller.selectedTab.value = 0;
                      }),
                    ),
                    Expanded(
                      child: _buildTabButton('ONLINE', controller.selectedTab.value == 1, () {
                        controller.selectedTab.value = 1;
                      }),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Players List
            Expanded(
              child: Obx(
                () => ListView.separated(
                  itemCount: controller.players.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final player = controller.players[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: CustomColors.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: CustomColors.primaryPurple,
                            child: Icon(Icons.person, color: Colors.white),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              player.name,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                          Obx(() => Text(
                                '${player.score.value}',
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // Winner Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                color: CustomColors.surfaceLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.emoji_events_rounded, color: Colors.amber),
                      SizedBox(width: 8),
                      Text('Winner', style: TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Obx(() => Text(
                        controller.winnerName.value,
                        style: const TextStyle(color: CustomColors.primaryNeon, fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action Roll Button
            SizedBox(
              width: double.infinity,
              height: 54,
              child: ElevatedButton(
                onPressed: controller.rollForCurrentPlayer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryPurple,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                ),
                child: const Text('ROLL DICE', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? CustomColors.primaryPurple : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : CustomColors.textSecondary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}