import 'package:dice_app/feature/home/widgets/quick_action.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/home_controller.dart';
import '../widgets/home_header.dart';
import '../widgets/quick_roll_card.dart';

import '../widgets/recent_roll_card.dart';
import '../widgets/home_stat_card.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0C1B),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const HomeHeader(),
              const SizedBox(height: 20),
              QuickRollCard(onRoll: controller.rollDice),
              const SizedBox(height: 20),
              const QuickActions(),
              const SizedBox(height: 20),
              Obx(() => RecentRollCard(lastResult: controller.homeData.value.lastRoll)),
              const SizedBox(height: 16),
              Obx(() => Row(
                children: [
                  HomeStatCard(title: 'Total Rolls', value: '${controller.homeData.value.totalRolls}'),
                  const SizedBox(width: 12),
                  HomeStatCard(title: 'Last Roll', value: '${controller.homeData.value.lastRoll}'),
                ],
              )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: controller.selectedBottomNavIndex.value,
        onTap: controller.changeBottomNav,
        backgroundColor: const Color(0xFF0F0C1B),
        selectedItemColor: Colors.purpleAccent,
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.style), label: 'Roll'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      )),
    );
  }
}