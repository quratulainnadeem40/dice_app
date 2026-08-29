import 'package:dice_app/core/navigation/widget/main_screen.dart';
import 'package:dice_app/feature/Roll_dice/view/Roll_dice_screen.dart';
import 'package:dice_app/feature/home/view/home_screen.dart';
import 'package:dice_app/feature/setting/view/setting_screen.dart';
import 'package:dice_app/history/view/history_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';


class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.MAIN, page: () => MainScreen()),
    GetPage(name: AppRoutes.HOME, page: () => const HomeScreen()),
    GetPage(name: AppRoutes.ROLL, page: () => const RollDiceScreen()),
    GetPage(name: AppRoutes.SETTINGS, page: () => const SettingsScreen()),
    GetPage(name: AppRoutes.HISTORY, page: () => const HistoryScreen()),
  ];
}