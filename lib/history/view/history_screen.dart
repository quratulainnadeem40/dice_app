import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';

import '../controller/history_controller.dart';
import '../widgets/history_card.dart';
import '../widgets/history_header.dart';
import '../widgets/history_empty_state.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: const Text('HISTORY'),
        backgroundColor: AppColors.darkBgSecondary,
        elevation: 0,
        actions: [
          Obx(
            () => controller.rollHistory.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.delete_outline_rounded),
                    onPressed: () {
                      Get.dialog(
                        AlertDialog(
                          backgroundColor: AppColors.darkBgSecondary,
                          title: const Text('Clear History'),
                          content: const Text(
                            'Are you sure you want to clear all history?',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Get.back(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                controller.clearHistory();
                                Get.back();
                              },
                              child: const Text(
                                'Clear',
                                style: TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : const SizedBox.shrink(),
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () => controller.rollHistory.isEmpty
              ? HistoryEmptyState(
                  onAction: () => Get.toNamed('/roll-dice'),
                )
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      // Header with stats
                      HistoryHeader(
                        totalRolls: controller.totalRolls,
                        averageRoll: controller.averageRoll,
                        maxRoll: controller.maxRoll,
                        minRoll: controller.minRoll,
                      ),
                      const SizedBox(height: 24),

                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.cardBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.borderColor),
                        ),
                        child: TextField(
                          onChanged: controller.setSearchQuery,
                          style: AppTextStyles.bodyMedium,
                          decoration: InputDecoration(
                            hintText: 'Search rolls...',
                            hintStyle: AppTextStyles.bodyMedium.copyWith(
                              color: AppColors.textTertiary,
                            ),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.search_rounded),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Filter chips
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Obx(
                          () => Row(
                            children: controller.availableFilters
                                .map(
                                  (filter) => Padding(
                                    padding:
                                        const EdgeInsets.only(right: 8),
                                    child: FilterChip(
                                      label: Text(filter),
                                      selected:
                                          controller.selectedFilter.value ==
                                              filter,
                                      onSelected: (_) =>
                                          controller.setFilter(filter),
                                      backgroundColor: AppColors.cardBg,
                                      selectedColor: AppColors.primaryPurple,
                                      labelStyle:
                                          AppTextStyles.labelSmall.copyWith(
                                        color: controller
                                                    .selectedFilter.value ==
                                                filter
                                            ? AppColors.textPrimary
                                            : AppColors.textSecondary,
                                      ),
                                      side: BorderSide(
                                        color: controller
                                                    .selectedFilter.value ==
                                                filter
                                            ? AppColors.primaryPurple
                                            : AppColors.borderColor,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // History list
                      Obx(
                        () => controller.filteredHistory.isEmpty
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 40,
                                  ),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.inbox_rounded,
                                        size: 60,
                                        color: AppColors.textTertiary,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        'No rolls found',
                                        style:
                                            AppTextStyles.bodyMedium.copyWith(
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    controller.filteredHistory.length,
                                itemBuilder: (context, index) {
                                  final item =
                                      controller.filteredHistory[index];
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 8),
                                    child: HistoryCard(
                                      item: item,
                                      onDelete: () =>
                                          controller.deleteItem(item.id),
                                    ),
                                  );
                                },
                              ),
                      ),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}