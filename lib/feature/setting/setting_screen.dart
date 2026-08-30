
import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/feature/home/widget/bottom_nav.dart';
import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:dice_app/feature/setting/widgets/animation_speed_slider.dart';
import 'package:dice_app/feature/setting/widgets/dice_color_selector.dart';
import 'package:dice_app/feature/setting/widgets/setting_section.dart';
import 'package:dice_app/feature/setting/widgets/sound_setting_tile.dart';
import 'package:dice_app/feature/setting/widgets/vibration_slides.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SettingsController controller = Get.isRegistered<SettingsController>()
        ? Get.find<SettingsController>()
        : Get.put(SettingsController(), permanent: true);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        controller.saveSettingsSilently();
        Get.offAllNamed(AppRoutes.home);
      },
      child: Scaffold(
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
                    _buildAppBar(controller),
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
                              title: '1. THEME & APPEARANCE',
                              child: Column(
                                children: const [
                                  DiceColorSelector(),
                                  SizedBox(height: 10),
                                  AnimationSpeedSlider(),
                                ],
                              ),
                            ),
                            SettingsSection(
                              title: '2. SOUND & VIBRATION',
                              child: Column(
                                children: const [
                                  SoundSettingTile(),
                                  SizedBox(height: 10),
                                  VibrationSettingTile(),
                                ],
                              ),
                            ),
                            _buildPreview(controller),
                            const SizedBox(height: 14),
                            _buildPrivacyPolicyTile(context),
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
      bottomNavigationBar: const AppBottomNav(currentIndex: 2),
    ),
  );
}

  Widget _buildPrivacyPolicyTile(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF080B29),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.08),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Get.toNamed(AppRoutes.privacyPolicy),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF8B2CFF).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.privacy_tip_rounded,
                    color: Color(0xFF8B2CFF),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Privacy Policy',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Innovexa Technologies • 100% Offline & Safe',
                        style: TextStyle(
                          color: Colors.white54,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Colors.white38,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(SettingsController controller) {
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
            onPressed: () {
              controller.saveSettingsSilently();
              Get.offAllNamed(AppRoutes.home);
            },
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

  Widget _buildPreview(SettingsController controller) {
    return SettingsSection(
      title: '3. PREVIEW',
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
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
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
                      Get.toNamed(AppRoutes.rollDice);
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
              color: color.withValues(alpha: 0.45),
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
}