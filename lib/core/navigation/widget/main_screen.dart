import 'package:dice_app/core/navigation/controller/navigation_controller.dart';
import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:dice_app/feature/Roll_dice/view/Roll_dice_screen.dart';
import 'package:dice_app/feature/home/view/home_screen.dart';
import 'package:dice_app/feature/setting/view/setting_screen.dart';
import 'package:dice_app/history/view/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainScreen extends GetView<NavigationController> {
  const MainScreen({Key? key}) : super(key: key);

  static const List<Widget> pages = [
    HomeScreen(),
    RollDiceScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  static const List<IconData> icons = [
    Icons.home_rounded,
    Icons.casino_rounded,
    Icons.history_rounded,
    Icons.settings_rounded,
  ];

  static const List<String> labels = [
    'Home',
    'Roll',
    'History',
    'Settings',
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.darkBgSecondary,
          selectedItemColor: AppColors.primaryPurple,
          unselectedItemColor: AppColors.textTertiary,
          elevation: 12,
          iconSize: 24,
          selectedLabelStyle: AppTextStyles.labelSmall.copyWith(
            color: AppColors.primaryPurple,
          ),
          unselectedLabelStyle: AppTextStyles.labelSmall.copyWith(
            color: AppColors.textTertiary,
          ),
          items: List.generate(
            icons.length,
            (index) => BottomNavigationBarItem(
              icon: Icon(icons[index]),
              label: labels[index],
              activeIcon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primaryPurple.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icons[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}