import 'package:get/get.dart';
import '../controller/roll_dice_controller.dart';

class RollDiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RollDiceController>(
      () => RollDiceController(),
    );
  }
}