import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  var diceCount = 1.obs;
  var diceSides = 6.obs;
  var selectedColor = const Color(0xFF8B5CF6).obs;
  var animationSpeed = 0.5.obs;
  var soundEnabled = true.obs;
  var vibrationEnabled = true.obs;

  final List<Color> availableColors = const [
    Color(0xFF8B5CF6),
    Color(0xFF3B82F6),
    Color(0xFF10B981),
    Color(0xFFF59E0B),
    Color(0xFFEF4444),
    Color(0xFFEC4899),
  ];

  void incrementDice() {
    if (diceCount.value < 6) diceCount.value++;
  }

  void decrementDice() {
    if (diceCount.value > 1) diceCount.value--;
  }

  void incrementSides() {
    if (diceSides.value < 20) diceSides.value++;
  }

  void decrementSides() {
    if (diceSides.value > 2) diceSides.value--;
  }

  void selectColor(Color color) {
    selectedColor.value = color;
  }

  void updateAnimationSpeed(double val) {
    animationSpeed.value = val;
  }

  void toggleSound(bool val) {
    soundEnabled.value = val;
  }

  void toggleVibration(bool val) {
    vibrationEnabled.value = val;
  }
}