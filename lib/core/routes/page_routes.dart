import 'package:dice_app/feature/Roll_dice/view/roll_disc_screen.dart';
import 'package:dice_app/feature/home/home_screen.dart';
import 'package:dice_app/feature/roll_dice/binding/roll_dice_binding.dart';

import 'package:dice_app/feature/home/binding/home_binding.dart';

import 'package:dice_app/feature/splash/binding/binding_splash.dart';

import 'package:dice_app/feature/splash/view/splash_screen.dart';
import 'package:get/get.dart';

import 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),

    GetPage(
      name: AppRoutes.rollDice,
      page: () => const RollDiceScreen(),
      binding: RollDiceBinding(),
    ),
  ];
}