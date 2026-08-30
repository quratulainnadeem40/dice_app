import 'package:dice_app/core/theme/custom_color.dart';
import 'package:dice_app/feature/history/model/history_model.dart';
import 'package:dice_app/feature/home/widget/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/history_controller.dart';
import '../widgets/history_card.dart';
import '../widgets/history_empty_state.dart';
import '../widgets/history_header.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(
          () => HistoryHeader(
            onBackPressed: () => Get.back(),
            onClearAllPressed: () => _showClearAllDialog(context),
            showClearButton: controller.historyList.isNotEmpty,
          ),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 750),
          child: Obx(() {
            if (controller.historyList.isEmpty) {
              return const HistoryEmptyState();
            }

            return Column(
              children: [
                // ====================================================
                // TOP SUMMARY BAR (Rolls count + Clear button)
                // ====================================================
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF191636).withValues(alpha: 0.8),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: AppColors.purple.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.history_rounded,
                              color: AppColors.violet,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${controller.historyList.length} ${controller.historyList.length == 1 ? 'Roll' : 'Rolls'} Recorded',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () => _showClearAllDialog(context),
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.delete_sweep_rounded,
                                  color: Colors.redAccent,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Clear All',
                                  style: TextStyle(
                                    color: Colors.redAccent.withValues(alpha: 0.9),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // ====================================================
                // LIST OF ROLLS
                // ====================================================
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 20.0),
                    itemCount: controller.historyList.length,
                    itemBuilder: (context, index) {
                      final RollHistoryModel item = controller.historyList[index];
                      return HistoryCard(
                        item: item,
                        onDismissed: () {
                          final removedItem = item;
                          controller.removeHistory(index);

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor:
                                  AppColors.purple.withValues(alpha: 0.95),
                              content: const Text(
                                'Roll deleted',
                                style: TextStyle(color: AppColors.white),
                              ),
                              action: SnackBarAction(
                                label: 'UNDO',
                                textColor: AppColors.violet,
                                onPressed: () {
                                  controller.insertHistory(index, removedItem);
                                },
                              ),
                              duration: const Duration(seconds: 3),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: const AppBottomNav(currentIndex: 1),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF1A153A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColors.purple.withValues(alpha: 0.3),
            width: 1.2,
          ),
        ),
        title: const Row(
          children: [
            Icon(Icons.delete_forever_rounded, color: Colors.redAccent, size: 24),
            SizedBox(width: 10),
            Text(
              'Clear History?',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        content: const Text(
          'Are you sure you want to delete all saved roll history? This action cannot be undone.',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white60, fontWeight: FontWeight.w600),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            onPressed: () {
              controller.clearAllHistory();
              Get.back();
              Get.snackbar(
                'History Cleared',
                'All roll history has been removed.',
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: const Color(0xFF1E1442),
                colorText: Colors.white,
                margin: const EdgeInsets.all(16),
                duration: const Duration(seconds: 2),
              );
            },
            icon: const Icon(Icons.delete_outline, color: Colors.white, size: 18),
            label: const Text(
              'Clear All',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}