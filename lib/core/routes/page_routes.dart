import 'package:dice_app/core/navigation/binding/navigation_binding.dart';
import 'package:dice_app/core/navigation/widget/main_screen.dart';
import 'package:dice_app/feature/Multiplayers/binding/multi_player_binding.dart';
import 'package:dice_app/feature/Roll_dice/binding/Roll_dice.binding.dart';
import 'package:dice_app/feature/Roll_dice/view/Roll_dice_screen.dart';
import 'package:dice_app/feature/home/binding/home_binding.dart';
import 'package:dice_app/feature/home/view/home_screen.dart';
import 'package:dice_app/feature/setting/binding/setting_bindind.dart';
import 'package:dice_app/feature/setting/view/setting_screen.dart';
import 'package:dice_app/feature/splash/binding/splash_binding.dart';
import 'package:dice_app/feature/splash/views/splash_screen.dart';
import 'package:dice_app/history/binding/history_binding.dart';
import 'package:dice_app/history/view/history_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';
class AppPages {
  static const INITIAL = AppRoutes.splash;

  static final pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 400),
    ),
    
    GetPage(
      name: AppRoutes.main,
      page: () => const MainScreen(),
      binding: NavigationBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.rollDice,
      page: () => const RollDiceScreen(),
      binding: RollDiceBinding(),
      transition: Transition.downToUp,
    ),
    // GetPage(
    //   name: AppRoutes.multiplayer,
    //   page: () => const MultiplayerScreen(),
    //   binding: MultiplayerBinding(),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryScreen(),
      binding: HistoryBinding(),
      transition: Transition.rightToLeft,
    ),
  
    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
      transition: Transition.rightToLeft,
    ),
  ];
}