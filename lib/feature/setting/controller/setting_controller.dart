import 'package:dice_app/feature/setting/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingsController extends GetxController {
  final SettingsModel settings = SettingsModel();

  // Dice
  final RxInt diceCount = 3.obs;
  final RxInt diceSides = 6.obs;

  // Theme
  final Rx<Color> diceColor =
      const Color(0xFF8B2CFF).obs;

  // Animation
  final RxDouble animationSpeed = 0.5.obs;

  // Sound
  final RxBool soundEnabled = true.obs;
  final RxDouble soundVolume = 0.6.obs;

  // Vibration
  final RxBool vibrationEnabled = true.obs;
  final RxDouble vibrationIntensity = 0.65.obs;

  // Roll sound
  final RxInt selectedRollDice = 1.obs;

  // Available colors
  final List<Color> diceColors = const [
    Color(0xFF8B2CFF),
    Color(0xFF087FF5),
    Color(0xFF21C45A),
    Color(0xFFFF921C),
    Color(0xFFFF3D4F),
    Color(0xFFE9EDF5),
  ];

  void incrementDice() {
    if (diceCount.value < 10) {
      diceCount.value++;
    }
  }

  void decrementDice() {
    if (diceCount.value > 1) {
      diceCount.value--;
    }
  }

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

  void selectDiceColor(Color color) {
    diceColor.value = color;
  }

  void setAnimationSpeed(double value) {
    animationSpeed.value = value;
  }

  void toggleSound(bool value) {
    soundEnabled.value = value;
  }

  void setSoundVolume(double value) {
    soundVolume.value = value;
  }

  void toggleVibration(bool value) {
    vibrationEnabled.value = value;
  }

  void setVibrationIntensity(double value) {
    vibrationIntensity.value = value;
  }

  void selectRollDice(int value) {
    selectedRollDice.value = value;
  }

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