import 'package:dice_app/feature/Roll_dice/view/roll_disc_screen.dart';
import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:dice_app/feature/setting/widgets/animation_speed_slider.dart';
import 'package:dice_app/feature/setting/widgets/dice_color_selector.dart';
import 'package:dice_app/feature/setting/widgets/dice_count_selector.dart';
import 'package:dice_app/feature/setting/widgets/dices_sides_selector.dart';
import 'package:dice_app/feature/setting/widgets/setting_section.dart';
import 'package:dice_app/feature/setting/widgets/sound_setting_tile.dart';
import 'package:dice_app/feature/setting/widgets/vibration_slides.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF05071D),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isTablet = constraints.maxWidth >= 600;

            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: isTablet ? 900 : 650,
                ),
                child: Column(
                  children: [
                    _buildAppBar(),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: isTablet ? 28 : 16,
                          vertical: 16,
                        ),
                        child: Column(
                          children: [
                            SettingsSection(
                              title: '1. DICE CONFIGURATION',
                              child: Column(
                                children: const [
                                  DiceCountSelector(),
                                  SizedBox(height: 10),
                                  DiceSidesSelector(),
                                ],
                              ),
                            ),
                            SettingsSection(
                              title: '2. THEME & APPEARANCE',
                              child: Column(
                                children: const [
                                  DiceColorSelector(),
                                  SizedBox(height: 10),
                                  AnimationSpeedSlider(),
                                ],
                              ),
                            ),
                            SettingsSection(
                              title: '3. SOUND & VIBRATION',
                              child: Column(
                                children: [
                                  const SoundSettingTile(),
                                  const SizedBox(height: 10),
                                  const VibrationSettingTile(),
                                  const SizedBox(height: 10),
                                  _buildRollSound(),
                                ],
                              ),
                            ),
                            _buildPreview(),
                            const SizedBox(height: 4),
                            _buildSaveButton(),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: Color(0xFF070921),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF202449),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 21,
            ),
          ),
          const Expanded(
            child: Text(
              'SETTINGS',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 21,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _buildRollSound() {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF111437),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(
                  Icons.casino_rounded,
                  color: Color(0xFFB43DFF),
                ),
                SizedBox(width: 10),
                Text(
                  'Roll Sound',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: List.generate(
                3,
                (index) {
                  final dice = index + 1;
                  final selected = controller.selectedRollDice.value == dice;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.selectRollDice(dice),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        margin: EdgeInsets.only(
                          right: index == 2 ? 0 : 8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFF17183E)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected
                                ? const Color(0xFFB43DFF)
                                : const Color(0xFF292D55),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              selected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: selected
                                  ? const Color(0xFFB43DFF)
                                  : const Color(0xFF999CB8),
                              size: 18,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              'Dice $dice',
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : const Color(0xFFB5B7CC),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return SettingsSection(
      title: '4. PREVIEW',
      child: Obx(
        () {
          final isMultiColor = controller.diceColor.value == Colors.transparent;

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: const Color(0xFF080B29),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _previewDice(
                        isMultiColor
                            ? const Color(0xFF8B2CFF)
                            : controller.diceColor.value,
                        5,
                        -0.12,
                      ),
                      const SizedBox(width: 12),
                      _previewDice(
                        isMultiColor
                            ? const Color(0xFFFF3D4F)
                            : controller.diceColor.value,
                        6,
                        0.08,
                      ),
                      const SizedBox(width: 12),
                      _previewDice(
                        isMultiColor
                            ? const Color(0xFF087FF5)
                            : controller.diceColor.value,
                        4,
                        -0.08,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Roll the dice to preview your selected settings.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFC3C5D8),
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 14),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(() => const  RollDiceScreen());
                    },
                    icon: const Icon(
                      Icons.casino_rounded,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'ROLL DICE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8B22E9),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(13),
                      ),
                      elevation: 8,
                      shadowColor: const Color(0xFF8B22E9),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _previewDice(
    Color color,
    int value,
    double rotation,
  ) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.45),
              blurRadius: 20,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: _diceDots(value),
        ),
      ),
    );
  }

  Widget _diceDots(int value) {
    final patterns = <int, List<Alignment>>{
      1: [Alignment.center],
      2: [
        Alignment.topLeft,
        Alignment.bottomRight,
      ],
      3: [
        Alignment.topLeft,
        Alignment.center,
        Alignment.bottomRight,
      ],
      4: [
        Alignment.topLeft,
        Alignment.topRight,
        Alignment.bottomLeft,
        Alignment.bottomRight,
      ],
      5: [
        Alignment.topLeft,
        Alignment.topRight,
        Alignment.center,
        Alignment.bottomLeft,
        Alignment.bottomRight,
      ],
      6: [
        Alignment.topLeft,
        Alignment.centerLeft,
        Alignment.bottomLeft,
        Alignment.topRight,
        Alignment.centerRight,
        Alignment.bottomRight,
      ],
    };

    return Stack(
      children: patterns[value]!.map(
        (alignment) {
          return Align(
            alignment: alignment,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                height: 9,
                width: 9,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 58,
      child: ElevatedButton.icon(
        onPressed: controller.saveSettings,
        icon: const Icon(
          Icons.save_rounded,
          color: Colors.white,
        ),
        label: const Text(
          'SAVE SETTINGS',
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8B22E9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 8,
          shadowColor: const Color(0xFF8B22E9).withOpacity(0.4),
        ),
      ),
    );
  }
}