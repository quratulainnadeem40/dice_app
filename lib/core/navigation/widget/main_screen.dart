import 'package:dice_app/core/navigation/controller/navigation_controller.dart';
import 'package:dice_app/feature/Roll_dice/view/Roll_dice_screen.dart';
import 'package:dice_app/feature/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  final List<Widget> screens = const [
    HomePage(),
    RollDiceScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final NavigationController navController = Get.find<NavigationController>();

    return Obx(() => Scaffold(
          body: screens[navController.selectedIndex.value],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: navController.selectedIndex.value,
            onTap: (index) => navController.selectedIndex.value = index,
            backgroundColor: const Color(0xFF0F0B1E),
            selectedItemColor: const Color(0xFF8B5CF6),
            unselectedItemColor: Colors.white38,
            type: BottomNavigationBarType.fixed,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.casino), label: 'Roll'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'History'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        ));
  }
}