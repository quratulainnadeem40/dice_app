import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('SETTINGS', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('DICE CONFIGURATION', style: TextStyle(color: CustomColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            
            // Dice Count Selector
            _buildCounterTile(
              label: 'Number of Dice',
              valueObx: Obx(() => Text('${controller.numberOfDice.value}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              onDecrement: controller.decrementDice,
              onIncrement: controller.incrementDice,
            ),
            const SizedBox(height: 10),

            // Dice Sides Selector
            _buildCounterTile(
              label: 'Number of Sides',
              valueObx: Obx(() => Text('${controller.numberOfSides.value}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
              onDecrement: controller.decrementSides,
              onIncrement: controller.incrementSides,
            ),
            const SizedBox(height: 24),

            const Text('DICE THEME / COLOR', style: TextStyle(color: CustomColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildColorCircle(CustomColors.primaryPurple, 0, controller),
                _buildColorCircle(CustomColors.accentBlue, 1, controller),
                _buildColorCircle(CustomColors.accentOrange, 2, controller),
                _buildColorCircle(CustomColors.accentGreen, 3, controller),
                _buildColorCircle(CustomColors.accentRed, 4, controller),
              ],
            ),
            const SizedBox(height: 24),

            const Text('ANIMATION SPEED', style: TextStyle(color: CustomColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
            Obx(() => Slider(
              value: controller.animationSpeed.value,
              onChanged: (val) => controller.animationSpeed.value = val,
              activeColor: CustomColors.primaryNeon,
              inactiveColor: CustomColors.surfaceLight,
            )),
            const SizedBox(height: 24),

            const Text('SOUND & VIBRATION', style: TextStyle(color: CustomColors.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            
            Obx(() => _buildSwitchTile('Sound', controller.soundEnabled.value, (val) => controller.soundEnabled.value = val)),
            const SizedBox(height: 10),
            Obx(() => _buildSwitchTile('Vibration', controller.vibrationEnabled.value, (val) => controller.vibrationEnabled.value = val)),
          ],
        ),
      ),
    );
  }

  Widget _buildCounterTile({required String label, required Widget valueObx, required VoidCallback onDecrement, required VoidCallback onIncrement}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: CustomColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Row(
            children: [
              IconButton(onPressed: onDecrement, icon: const Icon(Icons.remove, color: CustomColors.textSecondary)),
              valueObx,
              IconButton(onPressed: onIncrement, icon: const Icon(Icons.add, color: CustomColors.primaryNeon)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildColorCircle(Color color, int index, SettingsController controller) {
    return Obx(() {
      final isSelected = controller.selectedThemeIndex.value == index;
      return GestureDetector(
        onTap: () => controller.selectedThemeIndex.value = index,
        child: CircleAvatar(
          radius: 20,
          backgroundColor: color,
          child: isSelected ? const Icon(Icons.check, color: Colors.white) : null,
        ),
      );
    });
  }

  Widget _buildSwitchTile(String label, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(color: CustomColors.surface, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: CustomColors.primaryNeon,
          ),
        ],
      ),
    );
  }
}