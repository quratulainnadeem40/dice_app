import 'dart:math';
import 'package:dice_app/core/theme/custom_color.dart';
import 'package:dice_app/feature/history/model/history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  final RollHistoryModel item;
  final VoidCallback onDismissed;

  const HistoryCard({
    super.key,
    required this.item,
    required this.onDismissed,
  });

  static const List<Color> _playerColors = [
    Color(0xFFB14DFF), // Purple
    Color(0xFF3D9CFF), // Blue
    Color(0xFFFF4B4B), // Red
    Color(0xFF23C483), // Green
    Color(0xFFFF8A30), // Orange
    Color(0xFFFF4F9A), // Pink
    Color(0xFF00BCD4), // Cyan
    Color(0xFFFFC107), // Amber
  ];

  String _formatDate(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    final String timeString = DateFormat('h:mm a').format(dateTime);

    if (difference.inDays == 0 && now.day == dateTime.day) {
      return 'Today, $timeString';
    } else if (difference.inDays <= 1 &&
        (now.day - dateTime.day == 1 ||
            (now.day == 1 && dateTime.day != 1))) {
      return 'Yesterday, $timeString';
    } else {
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final int maxRoll =
        item.diceValues.isNotEmpty ? item.diceValues.reduce(max) : 0;
    final bool isMultiplayer = item.diceValues.length > 1;

    return Dismissible(
      key: ValueKey(item.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20.0),
        margin: const EdgeInsets.only(bottom: 14.0),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Delete',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            SizedBox(width: 8),
            Icon(Icons.delete_outline_rounded, color: Colors.white, size: 24),
          ],
        ),
      ),
      onDismissed: (_) => onDismissed(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 14.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1F1B3B).withValues(alpha: 0.95),
              const Color(0xFF131027).withValues(alpha: 0.98),
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.purple.withValues(alpha: 0.25),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 15,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======================================================
            // HEADER (Game Type + Date + Total Score Badge)
            // ======================================================
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.purple.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.casino_rounded,
                    color: AppColors.violet,
                    size: 18,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        _formatDate(item.dateTime),
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                // Total Score Badge
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B22E9).withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: const Color(0xFF8B22E9).withValues(alpha: 0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total: ',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.65),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${item.totalResult}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // Divider
            Container(
              height: 1,
              color: Colors.white.withValues(alpha: 0.07),
            ),

            const SizedBox(height: 14),

            // ======================================================
            // INDIVIDUAL PLAYERS & DICE ROLLS
            // ======================================================
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List.generate(
                item.diceValues.length,
                (i) {
                  final int diceVal = item.diceValues[i];
                  final String name = (i < item.playerNames.length &&
                          item.playerNames[i].trim().isNotEmpty)
                      ? item.playerNames[i].trim()
                      : 'Player ${i + 1}';

                  final Color playerColor =
                      _playerColors[i % _playerColors.length];
                  final bool isWinner = isMultiplayer && diceVal == maxRoll;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 7),
                    decoration: BoxDecoration(
                      color: isWinner
                          ? playerColor.withValues(alpha: 0.18)
                          : Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isWinner
                            ? playerColor.withValues(alpha: 0.7)
                            : Colors.white.withValues(alpha: 0.08),
                        width: isWinner ? 1.4 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Player Initial / Dot
                        Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: playerColor,
                            boxShadow: [
                              BoxShadow(
                                color: playerColor.withValues(alpha: 0.6),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 7),
                        // Player Name
                        ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 110),
                          child: Text(
                            name,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: isWinner
                                  ? Colors.white
                                  : Colors.white.withValues(alpha: 0.85),
                              fontSize: 12,
                              fontWeight: isWinner
                                  ? FontWeight.w700
                                  : FontWeight.w500,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Dice Value Badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 2),
                          decoration: BoxDecoration(
                            color: playerColor.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '$diceVal',
                            style: TextStyle(
                              color: isWinner ? Colors.white : playerColor,
                              fontSize: 13,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        if (isWinner) ...[
                          const SizedBox(width: 4),
                          const Text(
                            '👑',
                            style: TextStyle(fontSize: 11),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}