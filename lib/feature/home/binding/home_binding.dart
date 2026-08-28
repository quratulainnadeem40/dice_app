import 'package:dice_app/feature/home/controller/home_controller.dart';
import 'package:get/get.dart';
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}