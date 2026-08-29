import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/achievement_model.dart';

class AchievementController extends GetxController {
  var achievements = <AchievementModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAchievements();
  }

  void loadAchievements() {
    achievements.value = [
      AchievementModel(
        id: '1',
        title: 'First Roll',
        description: 'Roll the dice for the very first time',
        icon: Icons.casino_outlined,
        currentProgress: 1,
        maxProgress: 1,
        isUnlocked: true,
      ),
      AchievementModel(
        id: '2',
        title: 'High Roller',
        description: 'Roll a total sum of 12 in a single roll',
        icon: Icons.filter_6_rounded,
        currentProgress: 1,
        maxProgress: 1,
        isUnlocked: true,
      ),
      AchievementModel(
        id: '3',
        title: 'Dice Master',
        description: 'Complete 50 rolls in total',
        icon: Icons.workspace_premium_rounded,
        currentProgress: 24,
        maxProgress: 50,
        isUnlocked: false,
      ),
      AchievementModel(
        id: '4',
        title: 'Party Starter',
        description: 'Play a multiplayer game with 4 players',
        icon: Icons.groups_rounded,
        currentProgress: 2,
        maxProgress: 4,
        isUnlocked: false,
      ),
    ];
  }

  int get unlockedCount => achievements.where((a) => a.isUnlocked).length;
}