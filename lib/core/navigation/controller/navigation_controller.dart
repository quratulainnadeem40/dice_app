import 'package:get/get.dart';

class NavigationController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    if (index >= 0 && index < 4) {
      currentIndex.value = index;
    }
  }

  void resetToHome() {
    currentIndex.value = 0;
  }
}