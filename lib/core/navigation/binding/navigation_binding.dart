import 'package:get/get.dart';
import 'package:dice_app/feature/home/controller/home_controller.dart';
import 'package:dice_app/feature/Roll_dice/controller/roll_dice_controller.dart';
import 'package:dice_app/history/controller/history_controller.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<RollDiceController>(() => RollDiceController());
    Get.lazyPut<HistoryController>(() => HistoryController());
  }
}