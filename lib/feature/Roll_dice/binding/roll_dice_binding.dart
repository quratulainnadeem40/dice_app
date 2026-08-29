
import 'package:dice_app/feature/Roll_dice/controller/roll_disc_controller.dart';
import 'package:get/get.dart';

class RollDiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RollDiceController>(
      () => RollDiceController(),
    );
  }
}