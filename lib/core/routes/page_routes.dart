// import 'package:get/get.dart';
// import 'app_routes.dart';
// import '../../features/splash/view/splash_screen.dart';
// import '../../features/splash/binding/splash_binding.dart';
// import '../../features/onboarding/view/onboarding_screen.dart';
// import '../../features/onboarding/binding/onboarding_binding.dart';
// import '../../core/navigation/main_screen.dart';
// import '../../core/navigation/navigation_binding.dart';
// import '../../features/home/view/home_screen.dart';
// import '../../features/home/binding/home_binding.dart';
// import '../../features/roll_dice/view/roll_dice_screen.dart';
// import '../../features/roll_dice/binding/roll_dice_binding.dart';
// import '../../features/multiplayer/view/multiplayer_screen.dart';
// import '../../features/multiplayer/binding/multiplayer_binding.dart';
// import '../../features/history/view/history_screen.dart';
// import '../../features/history/binding/history_binding.dart';
// import '../../features/achievements/view/achievement_screen.dart';
// import '../../features/achievements/binding/achievement_binding.dart';
// import '../../features/settings/view/settings_screen.dart';
// import '../../features/settings/binding/settings_binding.dart';

// class AppPages {
//   static const INITIAL = AppRoutes.splash;

//   static final pages = [
//     GetPage(
//       name: AppRoutes.splash,
//       page: () => const SplashScreen(),
//       binding: SplashBinding(),
//       transition: Transition.fade,
//       transitionDuration: const Duration(milliseconds: 400),
//     ),
//     GetPage(
//       name: AppRoutes.onboarding,
//       page: () => const OnboardingScreen(),
//       binding: OnboardingBinding(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: AppRoutes.main,
//       page: () => const MainScreen(),
//       binding: NavigationBinding(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: AppRoutes.home,
//       page: () => const HomeScreen(),
//       binding: HomeBinding(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: AppRoutes.rollDice,
//       page: () => const RollDiceScreen(),
//       binding: RollDiceBinding(),
//       transition: Transition.bottomToTop,
//     ),
//     GetPage(
//       name: AppRoutes.multiplayer,
//       page: () => const MultiplayerScreen(),
//       binding: MultiplayerBinding(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: AppRoutes.history,
//       page: () => const HistoryScreen(),
//       binding: HistoryBinding(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: AppRoutes.achievements,
//       page: () => const AchievementScreen(),
//       binding: AchievementBinding(),
//       transition: Transition.rightToLeft,
//     ),
//     GetPage(
//       name: AppRoutes.settings,
//       page: () => const SettingsScreen(),
//       binding: SettingsBinding(),
//       transition: Transition.rightToLeft,
//     ),
//   ];
// }