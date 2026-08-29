import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  final VoidCallback onClear;

  const HistoryHeader({
    Key? key,
    required this.onClear,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'RECENT ROLLS',
          style: TextStyle(
            color: Colors.white54,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        TextButton.icon(
          onPressed: onClear,
          icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 18),
          label: const Text(
            'Clear All',
            style: TextStyle(color: Colors.redAccent, fontSize: 13),
          ),
        ),
      ],
    );
  }
}