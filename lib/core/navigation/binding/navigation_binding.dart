import 'package:dice_app/core/navigation/controller/navigation_controller.dart';
import 'package:dice_app/feature/Roll_dice/controller/roll_dice_controller.dart';

import 'package:dice_app/feature/home/controller/home_controller.dart';
import 'package:dice_app/feature/setting/controller/setting_%20controller.dart';
import 'package:dice_app/history/controller/history_controller.dart';
import 'package:get/get.dart';

class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavigationController>(() => NavigationController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<RollDiceController>(() => RollDiceController());
    Get.lazyPut<HistoryController>(() => HistoryController());
    Get.lazyPut<SettingsController>(() => SettingsController());
  }
}