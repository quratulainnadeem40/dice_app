import 'dart:math';
import 'package:dice_app/core/constant/app_constant.dart';
import 'package:dice_app/feature/Roll_dice/model/roll_dice_model.dart';
import 'package:get/get.dart';
import '../../../core/services/sound_service.dart';
import '../../../core/services/vibration_service.dart';


class RollDiceController extends GetxController {
  final soundService = Get.find<SoundService>();
  final vibrationService = Get.find<VibrationService>();

  final isRolling = false.obs;
  final lastResult = <int>[].obs;
  final rollTotal = 0.obs;
  final rollHistory = <DiceResult>[].obs;

  final diceCount = AppConstants.defaultDiceCount.obs;
  final diceSides = AppConstants.defaultDiceSides.obs;
  final animationSpeed = 1.0.obs;

  final selectedColor = 'purple'.obs;
  final diceColors = ['purple', 'blue', 'orange', 'red', 'green', 'gray'];

  @override
  void onInit() {
    super.onInit();
    _loadSavedSettings();
  }

  void _loadSavedSettings() {
    // Load dice configuration from storage
    // This can be extended to load from GetStorage
  }

  Future<void> rollDice() async {
    if (isRolling.value) return;

    isRolling.value = true;
    lastResult.clear();
    rollTotal.value = 0;

    // Vibration feedback
    await vibrationService.heavyVibration();

    // Play rolling sound
    await soundService.playDiceRollSound();

    // Simulate rolling animation
    await Future.delayed(Duration(
      milliseconds: (600 / animationSpeed.value).toInt(),
    ));

    // Generate results
    final random = Random();
    int total = 0;

    for (int i = 0; i < diceCount.value; i++) {
      final result = random.nextInt(diceSides.value) + 1;
      lastResult.add(result);
      total += result;
    }

    rollTotal.value = total;

    // Save to history
    rollHistory.insert(
      0,
      DiceResult(
        results: List.from(lastResult),
        total: total,
        diceCount: diceCount.value,
        diceSides: diceSides.value,
        timestamp: DateTime.now(),
      ),
    );

    // More vibration feedback
    await vibrationService.patternVibration();

    isRolling.value = false;
  }

  void incrementDiceCount() {
    if (diceCount.value < AppConstants.maxDiceCount) {
      diceCount.value++;
    }
  }

  void decrementDiceCount() {
    if (diceCount.value > AppConstants.minDiceCount) {
      diceCount.value--;
    }
  }

  void incrementDiceSides() {
    if (diceSides.value < AppConstants.maxDiceSides) {
      diceSides.value++;
    }
  }

  void decrementDiceSides() {
    if (diceSides.value > AppConstants.minDiceSides) {
      diceSides.value--;
    }
  }

  void setDiceCount(int count) {
    if (count >= AppConstants.minDiceCount &&
        count <= AppConstants.maxDiceCount) {
      diceCount.value = count;
    }
  }

  void setDiceSides(int sides) {
    if (sides >= AppConstants.minDiceSides &&
        sides <= AppConstants.maxDiceSides) {
      diceSides.value = sides;
    }
  }

  void setAnimationSpeed(double speed) {
    animationSpeed.value = speed;
  }

  void setDiceColor(String color) {
    if (diceColors.contains(color)) {
      selectedColor.value = color;
    }
  }

  void clearHistory() {
    rollHistory.clear();
  }

  List<int> getLastRolls(int count) {
    return rollHistory.take(count).map((r) => r.total).toList();
  }
}