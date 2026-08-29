// import 'package:dice_app/core/navigation/controller/navigation_controller.dart';
// import 'package:get/get.dart';
// import '../model/home_model.dart';

// class HomeController extends GetxController {
//   final Rxn<HomeModel> homeData = Rxn<HomeModel>();

//   @override
//   void onInit() {
//     super.onInit();
//     fetchHomeData();
//   }

//   void fetchHomeData() {
//     homeData.value = HomeModel(
//       userName: 'Player 1',
//       totalRolls: 16,
//       lastRollResult: 4,
//       recentAchievement: 'First Roll',
//     );
//   }

//   void goToRollScreen() {
//   if (Get.isRegistered<NavigationController>()) {
//     Get.find<NavigationController>().changePage(1);
//   }
// }

// void goToHistoryScreen() {
//   if (Get.isRegistered<NavigationController>()) {
//     Get.find<NavigationController>().changePage(2);
//   }
// }
//   }
import 'package:get/get.dart';
import '../model/home_model.dart';

class HomeController extends GetxController {
  var homeData = HomeModel(
    totalRolls: 16,
    lastRoll: 4,
    userName: 'User',
  ).obs;

  var selectedBottomNavIndex = 0.obs;

  void rollDice() {
    // Dice roll logic here
  }

  void changeBottomNav(int index) {
    selectedBottomNavIndex.value = index;
  }
}
