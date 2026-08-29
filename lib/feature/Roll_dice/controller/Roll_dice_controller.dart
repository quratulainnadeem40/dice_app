import 'dart:async';
import 'dart:math';
import 'package:dice_app/feature/Roll_dice/model/roll_dice_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RollDiceController extends GetxController {
  var diceList = <DiceModel>[].obs;
  var isRolling = false.obs;
  var totalSum = 0.obs;

  // Image waley unique colors palette
  final List<Color> multiColors = const [
    Color(0xFF8A2BE2), // Purple
    Color(0xFF1E90FF), // Blue
    Color(0xFFFF8C00), // Orange
    Color(0xFF32CD32), // Green
    Color(0xFFFF4500), // Red
    Color(0xFFFFD700), // Yellow
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
        // Har dice ko index ke hisab se alag color milega
        color: multiColors[index % multiColors.length], 
      ),
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