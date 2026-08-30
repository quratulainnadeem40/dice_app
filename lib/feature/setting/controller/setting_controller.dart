import 'package:dice_app/feature/setting/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsController extends GetxController {
  final SettingsModel settings = SettingsModel();

  // =========================
  // Dice Settings
  // =========================
  final RxInt diceCount = 3.obs;
  final RxInt diceSides = 6.obs;

  // =========================
  // Dice Color
  // =========================
  // Default mode -> Colors.transparent (Multi-Color / Rainbow Mode)
  final Rx<Color> diceColor = Colors.transparent.obs;

  final List<Color> diceColors = const [
    Colors.transparent, // Multi-Color / Rainbow Mode (First Option)
    Color(0xFF8B2CFF), // Purple
    Color(0xFF087FF5), // Blue
    Color(0xFF21C45A), // Green
    Color(0xFFFF921C), // Orange
    Color(0xFFFF3D4F), // Red
    Color(0xFFE9EDF5), // White
  ];

  // Helper Getter to easily check multi-color state anywhere
  bool get isMultiColor => diceColor.value == Colors.transparent;

  // =========================
  // Animation
  // =========================
  final RxDouble animationSpeed = 0.5.obs;

  // =========================
  // Sound
  // =========================
  final RxBool soundEnabled = true.obs;
  final RxDouble soundVolume = 0.6.obs;

  // =========================
  // Vibration
  // =========================
  final RxBool vibrationEnabled = true.obs;
  final RxDouble vibrationIntensity = 0.65.obs;

  // =========================
  // Roll Sound
  // =========================
  final RxInt selectedRollDice = 1.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialSettings();
  }

  // Initial Settings Sync
  void _loadInitialSettings() {
    diceCount.value = settings.diceCount;
    diceSides.value = settings.diceSides;
    diceColor.value = settings.diceColor;
    animationSpeed.value = settings.animationSpeed;
    soundEnabled.value = settings.soundEnabled;
    soundVolume.value = settings.soundVolume;
    vibrationEnabled.value = settings.vibrationEnabled;
    vibrationIntensity.value = settings.vibrationIntensity;
    selectedRollDice.value = settings.rollSoundDice;
  }

  // =========================
  // Dice Count
  // =========================
  void incrementDice() {
    if (diceCount.value < 7) {
      diceCount.value++;
    }
  }

  void decrementDice() {
    if (diceCount.value > 1) {
      diceCount.value--;
    }
  }

  // =========================
  // Dice Sides
  // =========================
  void incrementSides() {
    if (diceSides.value < 20) {
      diceSides.value++;
    }
  }

  void decrementSides() {
    if (diceSides.value > 3) {
      diceSides.value--;
    }
  }

  // =========================
  // Color Selection
  // =========================
  void selectDiceColor(Color color) {
    diceColor.value = color;
  }

  // Alias method (for UI consistency)
  void setDiceColor(Color color) {
    diceColor.value = color;
  }

  // =========================
  // Animation
  // =========================
  void setAnimationSpeed(double value) {
    animationSpeed.value = value;
  }

  // =========================
  // Sound
  // =========================
  void toggleSound(bool value) {
    soundEnabled.value = value;
  }

  void setSoundVolume(double value) {
    soundVolume.value = value;
  }

  // =========================
  // Vibration
  // =========================
  void toggleVibration(bool value) {
    vibrationEnabled.value = value;
  }

  void setVibrationIntensity(double value) {
    vibrationIntensity.value = value;
  }

  // =========================
  // Roll Sound
  // =========================
  void selectRollDice(int value) {
    selectedRollDice.value = value;
  }

  // =========================
  // Save Settings
  // =========================
  void saveSettings() {
    settings.diceCount = diceCount.value;
    settings.diceSides = diceSides.value;
    settings.diceColor = diceColor.value;
    settings.animationSpeed = animationSpeed.value;

    settings.soundEnabled = soundEnabled.value;
    settings.soundVolume = soundVolume.value;

    settings.vibrationEnabled = vibrationEnabled.value;
    settings.vibrationIntensity = vibrationIntensity.value;

    settings.rollSoundDice = selectedRollDice.value;

    Get.snackbar(
      'Settings Saved',
      'Your dice settings have been saved successfully.',
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      backgroundColor: const Color(0xFF171434),
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
    );
  }
}