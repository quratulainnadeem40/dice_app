import 'package:dice_app/feature/Roll_dice/view/roll_disc_screen.dart';
import 'package:dice_app/feature/history/binding/history_binding.dart';
import 'package:dice_app/feature/history/view/history_screen.dart';
import 'package:dice_app/feature/home/binding/home_binding.dart';
import 'package:dice_app/feature/home/home_screen.dart';
import 'package:dice_app/feature/privacy_policy/view/privacy_policy_screen.dart';
import 'package:dice_app/feature/roll_dice/binding/roll_dice_binding.dart';
import 'package:dice_app/feature/setting/binding/setting_binding.dart';
import 'package:dice_app/feature/setting/setting_screen.dart';
import 'package:dice_app/feature/splash/binding/binding_splash.dart';
import 'package:dice_app/feature/splash/view/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = <GetPage>[
    // ==========================================================
    // SPLASH
    // ==========================================================

    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    // ==========================================================
    // HOME
    // ==========================================================

    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

    // ==========================================================
    // ROLL DICE
    // ==========================================================

    GetPage(
      name: AppRoutes.rollDice,
      page: () => const RollDiceScreen(),
      binding: RollDiceBinding(),
    ),

    // ==========================================================
    // SETTINGS
    // ==========================================================

    GetPage(
      name: AppRoutes.settings,
      page: () => const SettingsScreen(),
      binding: SettingsBinding(),
    ),

    // ==========================================================
    // HISTORY
    // ==========================================================

    GetPage(
      name: AppRoutes.history,
      page: () => const HistoryScreen(),
      binding: HistoryBinding(),
    ),

    // ==========================================================
    // PRIVACY POLICY
    // ==========================================================

    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => const PrivacyPolicyScreen(),
    ),
  ];
}