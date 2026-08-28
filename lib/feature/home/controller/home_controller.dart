import 'dart:math';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final currentDice = 1.obs;
  final selectedBottomIndex = 0.obs;

  final random = Random();

  void rollDice() {
    currentDice.value = random.nextInt(6) + 1;
  }

  void changeBottomIndex(int index) {
    selectedBottomIndex.value = index;
  }
}