import 'package:dice_app/feature/home/controller/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomeBottomNav extends StatelessWidget {
  HomeBottomNav({super.key});

  final HomeController controller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF121022),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF302346),
          ),
        ),
        child: NavigationBar(
          height: 70,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIndex: controller.selectedBottomIndex.value,
          onDestinationSelected: controller.changeBottomIndex,
          indicatorColor: const Color(0xFF33204D),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(
                Icons.home,
                color: Color(0xFFB45CFF),
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              selectedIcon: Icon(
                Icons.history,
                color: Color(0xFFB45CFF),
              ),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(
                Icons.person,
                color: Color(0xFFB45CFF),
              ),
              label: 'Profile',
            ),
          ],
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}