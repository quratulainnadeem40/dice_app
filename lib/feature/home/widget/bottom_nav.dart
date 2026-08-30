import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/theme/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBottomNav extends StatelessWidget {
  final int? currentIndex;

  const AppBottomNav({
    super.key,
    this.currentIndex,
  });

  int get _resolvedIndex {
    if (currentIndex != null) {
      return currentIndex!;
    }
    final String currentRoute = Get.currentRoute;
    if (currentRoute == AppRoutes.history) return 1;
    if (currentRoute == AppRoutes.settings) return 2;
    return 0;
  }

  void _onDestinationSelected(int index) {
    if (index == 0) {
      // Home
      if (Get.currentRoute != AppRoutes.home) {
        Get.offAllNamed(AppRoutes.home);
      }
    } else if (index == 1) {
      // History
      if (Get.currentRoute != AppRoutes.history) {
        if (Get.currentRoute == AppRoutes.home) {
          Get.toNamed(AppRoutes.history);
        } else {
          Get.offNamed(AppRoutes.history);
        }
      }
    } else if (index == 2) {
      // Settings
      if (Get.currentRoute != AppRoutes.settings) {
        if (Get.currentRoute == AppRoutes.home) {
          Get.toNamed(AppRoutes.settings);
        } else {
          Get.offNamed(AppRoutes.settings);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _resolvedIndex;

    return Center(
      heightFactor: 1.0,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: Container(
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
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            indicatorColor: AppColors.purple.withValues(alpha: 0.18),
            destinations: const [
              // HOME
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

              // HISTORY
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

              // SETTINGS
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
            labelTextStyle: WidgetStatePropertyAll(
              TextStyle(
                color: Colors.white.withValues(alpha: 0.65),
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Backward compatibility alias
typedef HomeBottomNav = AppBottomNav;