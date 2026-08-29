import 'package:flutter/material.dart';

class HistoryHeader extends StatelessWidget {
  final VoidCallback onBackPressed;
  final VoidCallback onClearAllPressed;
  final bool showClearButton;

  const HistoryHeader({
    Key? key,
    required this.onBackPressed,
    required this.onClearAllPressed,
    this.showClearButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: onBackPressed,
      ),
      title: const Text(
        'Roll History',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      actions: [
        if (showClearButton)
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
            onPressed: onClearAllPressed,
          ),
      ],
    );
  }
}