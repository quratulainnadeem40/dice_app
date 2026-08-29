import 'package:get/get.dart';

class SettingsController extends GetxController {
  final RxInt numberOfDice = 3.obs;
  final RxInt numberOfSides = 6.obs;
  final RxInt selectedThemeIndex = 0.obs;
  final RxDouble animationSpeed = 0.5.obs;
  final RxBool soundEnabled = true.obs;
  final RxBool vibrationEnabled = true.obs;

  void incrementDice() {
    numberOfDice.value++;
  }

  void decrementDice() {
    if (numberOfDice.value > 1) {
      numberOfDice.value--;
    }
  }

  void incrementSides() {
    numberOfSides.value++;
  }

  void decrementSides() {
    if (numberOfSides.value > 2) {
      numberOfSides.value--;
    }
  }
}