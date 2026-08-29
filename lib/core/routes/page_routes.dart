import 'package:dice_app/core/navigation/binding/navigation_binding.dart';
import 'package:dice_app/core/navigation/widget/main_screen.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.INITIAL;

  static final routes = [
    GetPage(
      name: Routes.INITIAL,
      page: () => const MainScreen(),
      binding: NavigationBinding(),
    ),
  ];
}