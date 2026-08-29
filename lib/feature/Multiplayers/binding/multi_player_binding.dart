import 'package:dice_app/feature/Multiplayers/controller/multi_player_controller.dart';
import 'package:get/get.dart';


class MultiplayerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiplayerController>(() => MultiplayerController());
  }
}