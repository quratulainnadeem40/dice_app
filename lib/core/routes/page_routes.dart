import 'package:dice_app/feature/Roll_dice/binding/Roll_dice.binding.dart';
import 'package:dice_app/feature/home/binding/home_binding.dart';
import 'package:dice_app/feature/home/view/home_screen.dart';

import 'package:dice_app/feature/splash/binding/splash_binding.dart';
import 'package:dice_app/feature/splash/views/splash_screen.dart';
import 'package:dice_app/feature/roll_dice/view/roll_dice_screen.dart';

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