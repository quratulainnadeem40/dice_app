import 'package:dice_app/feature/achievement/controller/achivement_controller.dart';
import 'package:get/get.dart';


class AchievementBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AchievementController>(() => AchievementController());
  }
}