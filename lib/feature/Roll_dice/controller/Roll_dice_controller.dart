import 'dart:async';
import 'dart:math';
import 'package:dice_app/feature/Roll_dice/model/roll_dice_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class RollDiceController extends GetxController {
  var diceList = <DiceModel>[].obs;
  var isRolling = false.obs;
  var totalSum = 0.obs;

  @override
  void onInit() {
    super.onInit();
    initDice(count: 2, sides: 6, color: const Color(0xFF8B5CF6));
  }

  void initDice({int count = 2, int sides = 6, Color color = const Color(0xFF8B5CF6)}) {
    diceList.value = List.generate(
      count,
      (index) => DiceModel(id: index, sides: sides, color: color),
    );
    calculateTotal();
  }

  void rollDice() async {
    if (isRolling.value) return;

    isRolling.value = true;
    final random = Random();
    int counter = 0;

    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      counter++;
      for (var dice in diceList) {
        dice.currentValue = random.nextInt(dice.sides) + 1;
      }
      diceList.refresh();

      if (counter >= 10) {
        timer.cancel();
        isRolling.value = false;
        calculateTotal();
      }
    });
  }

  void calculateTotal() {
    totalSum.value = diceList.fold(0, (sum, dice) => sum + dice.currentValue);
  }
}