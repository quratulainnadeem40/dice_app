
import 'package:dice_app/core/theme/custom_color.dart';
import 'package:dice_app/feature/history/controller/history_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: Get.back,
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 18,
          ),
        ),
        title: const Text(
          'History',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          Obx(
            () {
              if (controller.history.isEmpty) {
                return const SizedBox.shrink();
              }

              return IconButton(
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      backgroundColor: const Color(0xFF202027),
                      title: const Text(
                        'Clear History?',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      content: const Text(
                        'All your roll history will be deleted.',
                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: Get.back,
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            controller.clearHistory();
                            Get.back();
                          },
                          child: const Text(
                            'Clear',
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(
                  Icons.delete_sweep_rounded,
                  color: Colors.white70,
                ),
              );
            },
          ),
        ],
      ),

      body: Obx(
        () {
          if (controller.history.isEmpty) {
            return _buildEmptyState();
          }

          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.fromLTRB(
              18,
              10,
              18,
              30,
            ),
            itemCount: controller.history.length,
            itemBuilder: (context, index) {
              final item = controller.history[index];

              return _buildHistoryCard(
                index,
                item,
              );
            },
          );
        },
      ),
    );
  }

  // ==========================================================
  // EMPTY STATE
  // ==========================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.purple.withValues(
                  alpha: 0.12,
                ),
                border: Border.all(
                  color: AppColors.purple.withValues(
                    alpha: 0.20,
                  ),
                ),
              ),
              child: const Icon(
                Icons.history_rounded,
                color: AppColors.violet,
                size: 38,
              ),
            ),

            const SizedBox(height: 22),

            const Text(
              'No Roll History',
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Your completed dice rolls\nwill appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // HISTORY CARD
  // ==========================================================

  Widget _buildHistoryCard(
    int index,
    dynamic item,
  ) {
    return Dismissible(
      key: ValueKey(
        '${item.dateTime.microsecondsSinceEpoch}_$index',
      ),
      direction: DismissDirection.endToStart,

      background: Container(
        margin: const EdgeInsets.only(bottom: 14),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 22),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(
            alpha: 0.15,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Icon(
          Icons.delete_rounded,
          color: Colors.redAccent,
        ),
      ),

      onDismissed: (_) {
        controller.removeHistory(index);
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withValues(
            alpha: 0.045,
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.07,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.18,
              ),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==================================================
            // TOP ROW
            // ==================================================

            Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(13),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.purple,
                        AppColors.violet,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.casino_rounded,
                    color: Colors.white,
                    size: 21,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${item.playerCount} '
                        '${item.playerCount == 1 ? 'Player' : 'Players'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        '${item.diceSides}-sided dice',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),

                Text(
                  _formatTime(item.dateTime),
                  style: const TextStyle(
                    color: Colors.white38,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // ==================================================
            // RESULTS
            // ==================================================

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                item.results.length,
                (resultIndex) {
                  return Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(13),
                      color: AppColors.purple.withValues(
                        alpha: 0.12,
                      ),
                      border: Border.all(
                        color: AppColors.purple.withValues(
                          alpha: 0.22,
                        ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${item.results[resultIndex]}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 15),

            // ==================================================
            // STATS
            // ==================================================

            Row(
              children: [
                _buildStat(
                  'TOTAL',
                  '${item.total}',
                ),
                _buildDivider(),
                _buildStat(
                  'HIGH',
                  '${item.highest}',
                ),
                _buildDivider(),
                _buildStat(
                  'LOW',
                  '${item.lowest}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // STAT
  // ==========================================================

  Widget _buildStat(
    String title,
    String value,
  ) {
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white38,
              fontSize: 8,
              fontWeight: FontWeight.w800,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DIVIDER
  // ==========================================================

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 25,
      color: Colors.white.withValues(
        alpha: 0.07,
      ),
    );
  }

  // ==========================================================
  // TIME FORMAT
  // ==========================================================

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour > 12
        ? dateTime.hour - 12
        : dateTime.hour == 0
            ? 12
            : dateTime.hour;

    final minute = dateTime.minute
        .toString()
        .padLeft(2, '0');

    final period =
        dateTime.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }
}