import 'package:dice_app/core/navigation/controller/navigation_controller.dart';
import 'package:get/get.dart';


class NavigationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NavigationController());
  }
}