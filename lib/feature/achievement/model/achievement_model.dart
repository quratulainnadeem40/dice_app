import 'package:flutter/material.dart';

class AchievementModel {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final int currentProgress;
  final int maxProgress;
  final bool isUnlocked;

  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.currentProgress,
    required this.maxProgress,
    this.isUnlocked = false,
  });

  double get progressPercentage => (currentProgress / maxProgress).clamp(0.0, 1.0);
}