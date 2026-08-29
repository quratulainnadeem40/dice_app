import 'package:dice_app/core/navigation/controller/navigation_controller.dart';
import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:dice_app/feature/Multiplayers/view/multiplayer_screen.dart';
import 'package:dice_app/feature/Roll_dice/view/Roll_dice_screen.dart';
import 'package:dice_app/feature/achievement/view/achievement_screen.dart';
import 'package:dice_app/feature/home/view/home_screen.dart';
import 'package:dice_app/feature/setting/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainScreen extends GetView<NavigationController> {
  const MainScreen({Key? key}) : super(key: key);

  final List<Widget> pages = const [
    HomeScreen(),
    RollDiceScreen(),
    MultiplayerScreen(),
    AchievementScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => pages[controller.currentIndex.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changePage,
          backgroundColor: ColorsCustom.cardBg,
          selectedItemColor: ColorsCustom.primary,
          unselectedItemColor: ColorsCustom.textSecondary,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.casino_rounded), label: 'Roll'),
            BottomNavigationBarItem(icon: Icon(Icons.people_rounded), label: 'Multi'),
            BottomNavigationBarItem(icon: Icon(Icons.emoji_events_rounded), label: 'Badges'),
            BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
          ],
        ),
      ),
    );
  }
}