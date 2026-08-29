import 'package:dice_app/feature/setting/controller/setting_%20controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: AppColors.darkBg,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'SETTINGS',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'DICE CONFIGURATION',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Number of Dice
            _buildCounterTile(
              label: 'Number of Dice',
              valueObx: Obx(
                () => Text(
                  '${controller.numberOfDice.value}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              onDecrement: controller.decrementDice,
              onIncrement: controller.incrementDice,
            ),

            const SizedBox(height: 10),

            // Number of Sides
            _buildCounterTile(
              label: 'Number of Sides',
              valueObx: Obx(
                () => Text(
                  '${controller.numberOfSides.value}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              onDecrement: controller.decrementSides,
              onIncrement: controller.incrementSides,
            ),

            const SizedBox(height: 24),

            // Theme
            const Text(
              'DICE THEME / COLOR',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColorCircle(
                  AppColors.dicePurple,
                  0,
                  controller,
                ),
                _buildColorCircle(
                  AppColors.diceBlue,
                  1,
                  controller,
                ),
                _buildColorCircle(
                  AppColors.diceOrange,
                  2,
                  controller,
                ),
                _buildColorCircle(
                  AppColors.diceGreen,
                  3,
                  controller,
                ),
                _buildColorCircle(
                  AppColors.diceRed,
                  4,
                  controller,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Animation Speed
            const Text(
              'ANIMATION SPEED',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            Obx(
              () => Slider(
                value: controller.animationSpeed.value,
                min: 0.1,
                max: 1.0,
                onChanged: (value) {
                  controller.animationSpeed.value = value;
                },
                activeColor: AppColors.primaryPurple,
                inactiveColor: AppColors.borderColor,
              ),
            ),

            const SizedBox(height: 24),

            // Sound & Vibration
            const Text(
              'SOUND & VIBRATION',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Obx(
              () => _buildSwitchTile(
                'Sound',
                controller.soundEnabled.value,
                (value) {
                  controller.soundEnabled.value = value;
                },
              ),
            ),

            const SizedBox(height: 10),

            Obx(
              () => _buildSwitchTile(
                'Vibration',
                controller.vibrationEnabled.value,
                (value) {
                  controller.vibrationEnabled.value = value;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterTile({
    required String label,
    required Widget valueObx,
    required VoidCallback onDecrement,
    required VoidCallback onIncrement,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),

          Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: const Icon(
                  Icons.remove,
                  color: AppColors.textSecondary,
                ),
              ),

              valueObx,

              IconButton(
                onPressed: onIncrement,
                icon: const Icon(
                  Icons.add,
                  color: AppColors.primaryPurple,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildColorCircle(
    Color color,
    int index,
    SettingsController controller,
  ) {
    return Obx(() {
      final isSelected =
          controller.selectedThemeIndex.value == index;

      return GestureDetector(
        onTap: () {
          controller.selectedThemeIndex.value = index;
        },
        child: Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected
                  ? AppColors.textPrimary
                  : Colors.transparent,
              width: 2,
            ),
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundColor: color,
            child: isSelected
                ? const Icon(
                    Icons.check,
                    color: Colors.white,
                  )
                : null,
          ),
        ),
      );
    });
  }

  Widget _buildSwitchTile(
    String label,
    bool value,
    Function(bool) onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.borderColor,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryPurple,
          ),
        ],
      ),
    );
  }
}