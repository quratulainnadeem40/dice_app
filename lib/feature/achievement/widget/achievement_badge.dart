import 'package:flutter/material.dart';

class AchievementBadge extends StatelessWidget {
  final IconData icon;
  final bool isUnlocked;

  const AchievementBadge({
    Key? key,
    required this.icon,
    required this.isUnlocked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: isUnlocked ? const Color(0xFF8B5CF6) : Colors.white10,
        shape: BoxShape.circle,
        boxShadow: isUnlocked
            ? [
                BoxShadow(
                  color: const Color(0xFF8B5CF6).withOpacity(0.4),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ]
            : [],
      ),
      child: Icon(
        icon,
        color: isUnlocked ? Colors.white : Colors.white38,
        size: 24,
      ),
    );
  }
}