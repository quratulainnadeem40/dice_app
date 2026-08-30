// import 'package:dice_app/feature/splash/controller/splash_controller.dart';

// import 'package:get/get.dart';



// class SplashBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<SplashController>(
//       () => SplashController(),
//     );
//   }
// }
import 'package:get/get.dart';

import '../controller/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
    );
  }
}
