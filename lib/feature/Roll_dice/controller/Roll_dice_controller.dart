import 'dart:math';

import 'package:get/get.dart';

class RollDiceController extends GetxController {
  final Random _random = Random();

  // Number of players: 1 to 4
  final playerCount = 1.obs;

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
    if (count < 1 || count > 4) return;

    playerCount.value = count;
    updateDiceCount();
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

    // Small animation delay
    await Future.delayed(
      const Duration(milliseconds: 500),
    );

    diceValues.assignAll(
      List.generate(
        playerCount.value,
        (_) => _random.nextInt(6) + 1,
      ),
    );

    isRolling.value = false;
  }
}