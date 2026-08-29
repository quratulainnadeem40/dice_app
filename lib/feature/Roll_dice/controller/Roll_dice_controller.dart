import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/roll_dice_model.dart';

class RollDiceController extends GetxController {
  var diceList = <DiceModel>[].obs;
  var isRolling = false.obs;
  var totalSum = 0.obs;

  // Visual matching colors for the glow theme
  final List<Color> multiColors = const [
    Color(0xFF8A2BE2), // Premium Purple
    Color(0xFF1E90FF), // Neon Blue
    Color(0xFFFF8C00), // Amber Orange
    Color(0xFF32CD32), // Emerald Green
    Color(0xFFFF4500), // Crimson Red
    Color(0xFFFFD700), // Gold Yellow
  ];

  @override
  void onInit() {
    super.onInit();
    initDice(count: 3, sides: 6);
  }

  void initDice({int count = 3, int sides = 6}) {
    diceList.value = List.generate(
      count,
      (index) => DiceModel(
        id: index,
        sides: sides,
        currentValue: index == 0 ? 2 : (index == 1 ? 5 : 3),
        color: multiColors[index % multiColors.length],
      ),
    );
    calculateTotal();
  }

  void rollDice() {
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