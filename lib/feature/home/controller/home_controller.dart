import 'dart:math';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var diceValue = 6.obs;
  var totalRolls = 15.obs;
  var isRolled = false.obs;

  void rollSingleDice() {
    diceValue.value = Random().nextInt(6) + 1;
    totalRolls.value++;
    isRolled.value = true;
  }
}