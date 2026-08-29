import 'package:dice_app/feature/setting/controller/setting_%20controller.dart';
import 'package:dice_app/feature/setting/widgets/dice_side_selector.dart';
import 'package:dice_app/feature/setting/widgets/setting_section.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/dice_count_selector.dart';

import '../widgets/dice_color_selector.dart';
import '../widgets/animation_speed_slider.dart';
import '../widgets/sound_setting_tile.dart';
import '../widgets/vibration_setting_tile.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0B1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text('SETTINGS', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          SettingsSection(
            title: 'Dice Configuration',
            child: Column(
              children: [
                Obx(() => DiceCountSelector(
                      count: controller.diceCount.value,
                      onIncrement: controller.incrementDice,
                      onDecrement: controller.decrementDice,
                    )),
                const SizedBox(height: 10),
                Obx(() => DiceSidesSelector(
                      sides: controller.diceSides.value,
                      onIncrement: controller.incrementSides,
                      onDecrement: controller.decrementSides,
                    )),
              ],
            ),
          ),
          SettingsSection(
            title: 'Dice Theme / Color',
            child: Obx(() => DiceColorSelector(
                  colors: controller.availableColors,
                  selectedColor: controller.selectedColor.value,
                  onSelectColor: controller.selectColor,
                )),
          ),
          SettingsSection(
            title: 'Animation Speed',
            child: Obx(() => AnimationSpeedSlider(
                  value: controller.animationSpeed.value,
                  onChanged: controller.updateAnimationSpeed,
                )),
          ),
          SettingsSection(
            title: 'Sound & Vibration',
            child: Column(
              children: [
                Obx(() => SoundSettingTile(
                      isEnabled: controller.soundEnabled.value,
                      onChanged: controller.toggleSound,
                    )),
                const SizedBox(height: 10),
                Obx(() => VibrationSettingTile(
                      isEnabled: controller.vibrationEnabled.value,
                      onChanged: controller.toggleVibration,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}