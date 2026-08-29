import 'package:dice_app/feature/history/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dice_app/core/theme/custom_color.dart'; // Ensure correct path for AppColors

class HistoryCard extends StatelessWidget {
  final RollHistoryModel item;
  final VoidCallback onDismissed;

  const HistoryCard({
    Key? key,
    required this.item,
    required this.onDismissed,
  }) : super(key: key);

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final String timeString = DateFormat('h:mm a').format(dateTime);

    if (difference.inDays == 0 && now.day == dateTime.day) {
      return 'Today, $timeString';
    } else if (difference.inDays <= 1 && (now.day - dateTime.day == 1 || (now.day == 1 && dateTime.day != 1))) {
      return 'Yesterday, $timeString';
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.8),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete, color: AppColors.white),
      ),
      onDismissed: (_) => onDismissed(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.purple.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.white.withOpacity(0.05),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.purple.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.casino,
                color: AppColors.violet,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Dice: ${item.diceValues.join(", ")} | Total: ${item.totalResult}',
                    style: const TextStyle(
                      color: AppColors.lightText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              _formatDate(item.dateTime),
              style: TextStyle(
                color: AppColors.lightText.withOpacity(0.6),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}