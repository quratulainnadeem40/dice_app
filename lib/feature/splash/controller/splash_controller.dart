import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    navigateToHome();
  }

  void navigateToHome() {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Get.offAllNamed(AppRoutes.main);
    });
  }
}