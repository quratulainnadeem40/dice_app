import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/theme/colors_custom.dart';
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
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: AppColors.purple.withValues(alpha: 0.18),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.purple.withValues(alpha: 0.08),
              blurRadius: 25,
            ),
          ],
        ),
        child: NavigationBar(
          height: 70,
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIndex: controller.selectedBottomIndex.value,

          onDestinationSelected: (index) {
            controller.changeBottomIndex(index);

            switch (index) {
              case 0:
                if (Get.currentRoute != AppRoutes.home) {
                  Get.offNamed(AppRoutes.home);
                }
                break;

              case 1:
                // History will be added later.
                break;

              case 2:
                if (Get.currentRoute != AppRoutes.settings) {
                  Get.offNamed(AppRoutes.settings);
                }
                break;
            }
          },

          indicatorColor: AppColors.purple.withValues(alpha: 0.18),

          destinations: const [
            NavigationDestination(
              icon: Icon(
                Icons.home_outlined,
                color: Colors.white54,
              ),
              selectedIcon: Icon(
                Icons.home_rounded,
                color: AppColors.violet,
              ),
              label: 'Home',
            ),

            NavigationDestination(
              icon: Icon(
                Icons.history_outlined,
                color: Colors.white54,
              ),
              selectedIcon: Icon(
                Icons.history_rounded,
                color: AppColors.violet,
              ),
              label: 'History',
            ),

            NavigationDestination(
  icon: Icon(
    Icons.settings_outlined,
    color: Colors.white54,
  ),
  selectedIcon: Icon(
    Icons.settings_rounded,
    color: AppColors.violet,
  ),
  label: 'Settings',
),
          ],

          labelTextStyle: const WidgetStatePropertyAll(
            TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}