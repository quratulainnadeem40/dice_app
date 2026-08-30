import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onClearAllPressed;
  final bool showClearButton;

  const HistoryHeader({
    super.key,
    required this.onBackPressed,
    required this.onClearAllPressed,
    this.showClearButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
        onPressed: onBackPressed,
      ),
      title: const Text(
        'Roll History',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
      centerTitle: true,
      actions: [
        if (showClearButton)
          IconButton(
            tooltip: 'Clear All History',
            icon: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.redAccent.withValues(alpha: 0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.redAccent,
                size: 20,
              ),
            ),
            onPressed: onClearAllPressed,
          ),
        const SizedBox(width: 8),
      ],
    );
  }
}