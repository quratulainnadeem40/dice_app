import 'package:dice_app/feature/setting/model/setting_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SettingsController extends GetxController {
  final GetStorage _storage = GetStorage();
  static const String _storageKey = 'app_dice_settings';

  final SettingsModel settings = SettingsModel();

  // =========================
  // Dice Settings (Controlled on Dice Screen)
  // =========================
  final RxInt diceCount = 1.obs;
  final RxInt diceSides = 6.obs;

  // =========================
  // Dice Color & Themes
  // =========================
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
  final RxInt settingsVersion = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialSettings();
  }

  // Load from Local Storage (GetStorage)
  void _loadInitialSettings() {
    try {
      final dynamic raw = _storage.read(_storageKey);
      if (raw != null && raw is Map) {
        final loaded = SettingsModel.fromMap(Map<String, dynamic>.from(raw));
        settings.diceCount = loaded.diceCount;
        settings.diceSides = loaded.diceSides;
        settings.diceColor = loaded.diceColor;
        settings.animationSpeed = loaded.animationSpeed;
        settings.soundEnabled = loaded.soundEnabled;
        settings.soundVolume = loaded.soundVolume;
        settings.vibrationEnabled = loaded.vibrationEnabled;
        settings.vibrationIntensity = loaded.vibrationIntensity;
        settings.rollSoundDice = loaded.rollSoundDice;
        debugPrint('Settings loaded from local storage successfully.');
      }
    } catch (e) {
      debugPrint('Error loading settings from storage: $e');
    }

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

  Future<void> _persistSettings() async {
    try {
      settings.diceCount = diceCount.value;
      settings.diceSides = diceSides.value;
      settings.diceColor = diceColor.value;
      settings.animationSpeed = animationSpeed.value;
      settings.soundEnabled = soundEnabled.value;
      settings.soundVolume = soundVolume.value;
      settings.vibrationEnabled = vibrationEnabled.value;
      settings.vibrationIntensity = vibrationIntensity.value;
      settings.rollSoundDice = selectedRollDice.value;

      await _storage.write(_storageKey, settings.toMap());
      settingsVersion.value++;
      debugPrint('Settings persisted to local storage.');
    } catch (e) {
      debugPrint('Error saving settings to storage: $e');
    }
  }

  // =========================
  // Dice Count & Sides Helpers
  // =========================
  void incrementDice() {
    if (diceCount.value < 8) {
      diceCount.value++;
      _persistSettings();
    }
  }

  void decrementDice() {
    if (diceCount.value > 1) {
      diceCount.value--;
      _persistSettings();
    }
  }

  void incrementSides() {
    if (diceSides.value < 20) {
      diceSides.value++;
      _persistSettings();
    }
  }

  void decrementSides() {
    if (diceSides.value > 3) {
      diceSides.value--;
      _persistSettings();
    }
  }

  // =========================
  // Color Selection
  // =========================
  void selectDiceColor(Color color) {
    diceColor.value = color;
    _persistSettings();
  }

  // Alias method
  void setDiceColor(Color color) {
    diceColor.value = color;
    _persistSettings();
  }

  // =========================
  // Animation
  // =========================
  void setAnimationSpeed(double value) {
    animationSpeed.value = value;
    _persistSettings();
  }

  // =========================
  // Sound
  // =========================
  void toggleSound(bool value) {
    soundEnabled.value = value;
    _persistSettings();
  }

  void setSoundVolume(double value) {
    soundVolume.value = value;
    _persistSettings();
  }

  // =========================
  // Vibration
  // =========================
  void toggleVibration(bool value) {
    vibrationEnabled.value = value;
    _persistSettings();
  }

  void setVibrationIntensity(double value) {
    vibrationIntensity.value = value;
    _persistSettings();
  }

  // =========================
  // Roll Sound
  // =========================
  void selectRollDice(int value) {
    selectedRollDice.value = value;
    _persistSettings();
  }

  // =========================
  // Save Settings
  // =========================
  void saveSettings() {
    _persistSettings();

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