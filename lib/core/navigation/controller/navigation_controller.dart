import 'package:get/get.dart';

class NavigationController extends GetxController {
  // Current tab index (0: Home, 1: Roll, 2: History, 3: Settings)
  var selectedIndex = 0.obs;

  // Tab change handler
  void changePage(int index) {
    selectedIndex.value = index;
  }

  // Programmatically specific screen par jane ke liye helper method
  void navigateToTab(int index) {
    selectedIndex.value = index;
  }
}