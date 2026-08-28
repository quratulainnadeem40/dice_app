import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:dice_app/feature/settings/controller/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Stack(
          children: [
            // Top glow
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.purple.withValues(alpha: 0.12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.purple.withValues(alpha: 0.12),
                      blurRadius: 100,
                      spreadRadius: 30,
                    ),
                  ],
                ),
              ),
            ),

            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(
                20,
                20,
                20,
                30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),

                  const SizedBox(height: 32),

                  _buildSectionTitle('GAME SETTINGS'),

                  const SizedBox(height: 14),

                  _buildSoundSetting(),

                  const SizedBox(height: 12),

                  _buildVibrationSetting(),

                  const SizedBox(height: 30),

                  _buildSectionTitle('APP'),

                  const SizedBox(height: 14),

                  _buildAboutTile(),

                  const SizedBox(height: 30),

                  _buildResetButton(),

                  const SizedBox(height: 30),

                  Center(
                    child: Text(
                      'DICE',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.25),
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 4,
                      ),
                    ),
                  ),

                  const SizedBox(height: 6),

                  Center(
                    child: Text(
                      'Roll • Play • Win',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.18),
                        fontSize: 10,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

 Widget _buildHeader() {
  return Row(
    children: [
      // Back Button
      GestureDetector(
       onTap: () {
  Get.offNamed(AppRoutes.home);
},
        child: Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFF121022),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: AppColors.purple.withValues(alpha: 0.15),
            ),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),

      const SizedBox(width: 14),

      // Settings Icon
      Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.purple,
              AppColors.violet,
              AppColors.blue,
            ],
          ),
        ),
        child: const Icon(
          Icons.settings_rounded,
          color: Colors.white,
          size: 26,
        ),
      ),

      const SizedBox(width: 14),

      const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SETTINGS',
            style: TextStyle(
              color: Colors.white,
              fontSize: 21,
              fontWeight: FontWeight.w900,
              letterSpacing: 2,
            ),
          ),
          SizedBox(height: 3),
          Text(
            'Customize your game',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 11,
            ),
          ),
        ],
      ),
    ],
  );
}
  // ============================================================
  // SECTION TITLE
  // ============================================================

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.42),
        fontSize: 11,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
      ),
    );
  }

  // ============================================================
  // SOUND
  // ============================================================

  Widget _buildSoundSetting() {
    return Obx(
      () => _buildSettingTile(
        icon: Icons.volume_up_rounded,
        title: 'Sound',
        subtitle: 'Dice rolling sound effects',
        value: controller.soundEnabled.value,
        onChanged: controller.toggleSound,
      ),
    );
  }

  // ============================================================
  // VIBRATION
  // ============================================================

  Widget _buildVibrationSetting() {
    return Obx(
      () => _buildSettingTile(
        icon: Icons.vibration_rounded,
        title: 'Vibration',
        subtitle: 'Haptic feedback when rolling',
        value: controller.vibrationEnabled.value,
        onChanged: controller.toggleVibration,
      ),
    );
  }

  // ============================================================
  // SETTING TILE
  // ============================================================

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF121022),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: AppColors.purple.withValues(alpha: 0.12),
            ),
            child: Icon(
              icon,
              color: AppColors.violet,
              size: 21,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.38),
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.purple,
            inactiveThumbColor: Colors.white54,
            inactiveTrackColor: Colors.white12,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ABOUT
  // ============================================================

  Widget _buildAboutTile() {
    return GestureDetector(
      onTap: () {
        Get.dialog(
          AlertDialog(
            backgroundColor: const Color(0xFF171229),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(22),
            ),
            title: const Text(
              'About Dice',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
            content: const Text(
              'A simple and fun dice game. '
              'Roll the dice, play with friends and enjoy the game!',
              style: TextStyle(
                color: Colors.white60,
                height: 1.5,
              ),
            ),
            actions: [
              TextButton(
                onPressed: Get.back,
                child: const Text(
                  'CLOSE',
                  style: TextStyle(
                    color: AppColors.violet,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF121022),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: AppColors.purple.withValues(alpha: 0.15),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: AppColors.blue.withValues(alpha: 0.10),
              ),
              child: const Icon(
                Icons.info_outline_rounded,
                color: AppColors.blue,
              ),
            ),

            const SizedBox(width: 13),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'About this dice application',
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Colors.white30,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // RESET
  // ============================================================

  Widget _buildResetButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: () {
          Get.dialog(
            AlertDialog(
              backgroundColor: const Color(0xFF171229),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(22),
              ),
              title: const Text(
                'Reset Settings?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              content: const Text(
                'Sound and vibration will be turned back on.',
                style: TextStyle(
                  color: Colors.white60,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: Get.back,
                  child: const Text(
                    'CANCEL',
                    style: TextStyle(
                      color: Colors.white54,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    controller.resetSettings();
                    Get.back();
                  },
                  child: const Text(
                    'RESET',
                    style: TextStyle(
                      color: AppColors.violet,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        icon: const Icon(
          Icons.refresh_rounded,
          size: 19,
        ),
        label: const Text(
          'RESET SETTINGS',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white60,
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.10),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(17),
          ),
        ),
      ),
    );
  }
}