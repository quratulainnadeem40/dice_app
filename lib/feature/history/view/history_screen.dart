import 'package:dice_app/feature/history/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dice_app/core/theme/custom_color.dart'; // Ensure correct path for AppColors

import '../controller/history_controller.dart';
import '../widgets/history_card.dart';
import '../widgets/history_empty_state.dart';
import '../widgets/history_header.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({Key? key}) : super(key: key);

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
      body: Obx(() {
        if (controller.historyList.isEmpty) {
          return const HistoryEmptyState();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16.0),
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
                    backgroundColor: AppColors.purple.withOpacity(0.9),
                    content: const Text(
                      'Item deleted',
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
        );
      }),
    );
  }

  void _showClearAllDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.purple.withOpacity(0.95),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Clear History?',
          style: TextStyle(color: AppColors.white),
        ),
        content: const Text(
          'This action cannot be undone. Are you sure you want to delete all roll history?',
          style: TextStyle(color: AppColors.lightText),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColors.lightText),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              controller.clearAllHistory();
              Get.back();
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}