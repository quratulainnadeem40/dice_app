import 'package:get/get.dart';

class NavigationController extends GetxController {
  final currentIndex = 0.obs;

  static const List<String> navigationTitles = [
    'Home',
    'Roll',
    'History',
    'Settings',
  ];

  void changeIndex(int index) {
    currentIndex.value = index;
  }

  void goToHome() => changeIndex(0);
  void goToRoll() => changeIndex(1);
  void goToHistory() => changeIndex(2);
  void goToSettings() => changeIndex(3);

  String get currentTitle => navigationTitles[currentIndex.value];
}