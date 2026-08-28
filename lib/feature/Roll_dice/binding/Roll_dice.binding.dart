import 'package:get/get.dart';
import 'package:dice_app/feature/roll_dice/controller/roll_dice_controller.dart';

class RollDiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RollDiceController>(
      () => RollDiceController(),
    );
  }
}