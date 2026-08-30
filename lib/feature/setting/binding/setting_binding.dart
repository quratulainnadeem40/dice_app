import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:get/get.dart';

class SettingsBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<SettingsController>()) {
      Get.put<SettingsController>(
        SettingsController(),
        permanent: true,
      );
    }
  }
}