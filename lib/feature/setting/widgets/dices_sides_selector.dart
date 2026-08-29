import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class DiceSidesSelector extends StatelessWidget {
  const DiceSidesSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Obx(
      () => Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF111437),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: const Color(0xFF7125D9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.change_history_rounded,
                color: Colors.white,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            const Expanded(
              child: Text(
                'Number of Sides',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            _SideButton(
              icon: Icons.remove,
              onTap: controller.decrementSides,
            ),

            Container(
              height: 44,
              width: 55,
              alignment: Alignment.center,
              color: const Color(0xFF0B0E2B),
              child: Text(
                '${controller.diceSides.value}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),

            _SideButton(
              icon: Icons.add,
              onTap: controller.incrementSides,
            ),
          ],
        ),
      ),
    );
  }
}

class _SideButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _SideButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: 44,
        width: 42,
        decoration: BoxDecoration(
          color: const Color(0xFF191C46),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFBB5AFF),
        ),
      ),
    );
  }
}