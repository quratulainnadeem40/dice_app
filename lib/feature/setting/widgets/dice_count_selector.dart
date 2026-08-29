import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class DiceCountSelector extends StatelessWidget {
  const DiceCountSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Obx(
      () => _SelectorContainer(
        icon: Icons.casino_rounded,
        title: 'Number of Dice',
        value: controller.diceCount.value,
        onMinus: controller.decrementDice,
        onPlus: controller.incrementDice,
      ),
    );
  }
}

class _SelectorContainer extends StatelessWidget {
  final IconData icon;
  final String title;
  final int value;
  final VoidCallback onMinus;
  final VoidCallback onPlus;

  const _SelectorContainer({
    required this.icon,
    required this.title,
    required this.value,
    required this.onMinus,
    required this.onPlus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: Icon(
              icon,
              color: Colors.white,
              size: 27,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          _ControlButton(
            icon: Icons.remove,
            onTap: onMinus,
          ),

          Container(
            height: 44,
            width: 55,
            alignment: Alignment.center,
            color: const Color(0xFF0B0E2B),
            child: Text(
              '$value',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          _ControlButton(
            icon: Icons.add,
            onTap: onPlus,
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFF191C46),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: 44,
          width: 42,
          child: Icon(
            icon,
            color: const Color(0xFFBB5AFF),
          ),
        ),
      ),
    );
  }
}