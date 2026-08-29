import 'dart:math';

import 'package:dice_app/core/dice_theme.dart';
import 'package:get/get.dart';

class RollDiceController extends GetxController {
  final Random _random = Random();

  // Number of players: 1 to 7
  final playerCount = 1.obs;

  // Number of dice sides
  final diceSides = 6.obs;

  // Selected dice theme
  final Rx<DiceTheme> selectedDiceTheme = DiceThemes.all.first.obs;

  // Dice value for each player
  final diceValues = <int>[1].obs;

  // Rolling state
  final isRolling = false.obs;

  @override
  void onInit() {
    super.onInit();
    updateDiceCount();
  }

  void setPlayerCount(int count) {
    if (count < 1 || count > 7) return;

    playerCount.value = count;
    updateDiceCount();
  }

  void setDiceSides(int sides) {
    if (sides < 2) return;

    diceSides.value = sides;
    updateDiceCount();
  }

  void setDiceTheme(DiceTheme theme) {
    selectedDiceTheme.value = theme;
  }

  void updateDiceCount() {
    diceValues.assignAll(
      List.generate(
        playerCount.value,
        (_) => 1,
      ),
    );
  }

  Future<void> rollAllDice() async {
    if (isRolling.value) return;

    isRolling.value = true;

    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    diceValues.assignAll(
      List.generate(
        playerCount.value,
        (_) => _random.nextInt(diceSides.value) + 1,
      ),
    );

    isRolling.value = false;
  }
}