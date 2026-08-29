import 'dart:math';
import 'package:get/get.dart';

class RollDiceController extends GetxController {
  final RxList<int> diceResults = <int>[1, 2, 3].obs;
  final RxInt numberOfDice = 3.obs;
  final RxInt numberOfSides = 6.obs;
  final RxBool isRolling = false.obs;

  int get totalSum => diceResults.fold(0, (sum, item) => sum + item);

  void rollDice() async {
    isRolling.value = true;
    
    // Simple animation simulation delay
    for (int i = 0; i < 5; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      diceResults.value = List.generate(
        numberOfDice.value,
        (_) => Random().nextInt(numberOfSides.value) + 1,
      );
    }
    
    isRolling.value = false;
  }

  void updateDiceConfig(int diceCount, int sides) {
    numberOfDice.value = diceCount;
    numberOfSides.value = sides;
    diceResults.value = List.generate(
      diceCount,
      (_) => Random().nextInt(sides) + 1,
    );
  }
}