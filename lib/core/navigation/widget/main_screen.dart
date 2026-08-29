import 'package:dice_app/core/navigation/controller/navigation_controller.dart';
import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:dice_app/feature/Roll_dice/view/Roll_dice_screen.dart';
import 'package:dice_app/feature/home/view/home_screen.dart';
import 'package:dice_app/feature/setting/view/setting_screen.dart';
import 'package:dice_app/history/view/history_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  final NavigationController controller = Get.put(NavigationController());

  final List<Widget> screens = [
    const HomeScreen(),
    const RollDiceScreen(),
    const HistoryScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: screens,
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: CustomColors.surface,
            border: Border(top: BorderSide(color: CustomColors.surfaceLight, width: 1)),
          ),
          child: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            backgroundColor: CustomColors.surface,
            selectedItemColor: CustomColors.primaryNeon,
            unselectedItemColor: CustomColors.textSecondary,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.casino_rounded), label: 'Roll'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'History'),
              BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
            ],
          ),
        ),
      ),
    );
  }
}