import 'package:dice_app/core/Services/sound_service.dart';
import 'package:dice_app/core/Services/storage_service.dart';
import 'package:dice_app/core/Services/vibration_service.dart';
import 'package:get/get.dart';


class InitialBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    // Services
    Get.put(StorageService(), permanent: true);
    Get.put(SoundService(), permanent: true);
    Get.put(VibrationService(), permanent: true);
  }
}