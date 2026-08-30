import 'package:dice_app/feature/Roll_dice/controller/roll_disc_controller.dart';
import 'package:get/get.dart';

class RollDiceBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<RollDiceController>()) {
      Get.put<RollDiceController>(
        RollDiceController(),
        permanent: true,
      );
    }
  }
}