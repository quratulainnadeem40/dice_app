import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:dice_app/feature/profile/controller/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'PROFILE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            children: [
              _buildProfileHeader(),

              const SizedBox(height: 24),

              _buildSectionTitle('YOUR STATS'),

              const SizedBox(height: 12),

              _buildStats(),

              const SizedBox(height: 28),

              _buildSectionTitle('SETTINGS'),

              const SizedBox(height: 12),

              _buildSoundSetting(),

              const SizedBox(height: 10),

              _buildVibrationSetting(),

              const SizedBox(height: 10),

             
              _buildAboutSetting(),

              const SizedBox(height: 28),

              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  // ================================================================
  // PROFILE HEADER
  // ================================================================

  Widget _buildProfileHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF241440),
            Color(0xFF130D27),
          ],
        ),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.12),
            blurRadius: 30,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        children: [
          // Avatar
          Container(
            width: 92,
            height: 92,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.violet,
                  AppColors.purple,
                  AppColors.blue,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.purple.withValues(alpha: 0.35),
                  blurRadius: 28,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: const Icon(
              Icons.person_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),

          const SizedBox(height: 17),

          Obx(
            () => Text(
              controller.playerName.value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 5),

          const Text(
            'Dice Player',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),

          const SizedBox(height: 18),

          OutlinedButton.icon(
            onPressed: _showEditNameDialog,
            icon: const Icon(
              Icons.edit_rounded,
              size: 16,
            ),
            label: const Text(
              'EDIT PROFILE',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.violet,
              side: BorderSide(
                color: AppColors.purple.withValues(alpha: 0.45),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 11,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SECTION TITLE
  // ================================================================

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.3,
        ),
      ),
    );
  }

  // ================================================================
  // STATS
  // ================================================================

  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.casino_rounded,
            title: 'Total Rolls',
            value: controller.totalRolls,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _buildStatCard(
            icon: Icons.emoji_events_rounded,
            title: 'Best Roll',
            value: controller.bestRoll,
          ),
        ),

        const SizedBox(width: 10),

        Expanded(
          child: _buildStatCard(
            icon: Icons.analytics_rounded,
            title: 'Average',
            value: controller.averageRoll,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required Rx<dynamic> value,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF121022),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.16),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: AppColors.violet,
            size: 21,
          ),

          const SizedBox(height: 9),

          Obx(
            () => Text(
              '${value.value}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          const SizedBox(height: 4),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // SOUND
  // ================================================================

  Widget _buildSoundSetting() {
    return Obx(
      () => _buildSettingTile(
        icon: Icons.volume_up_rounded,
        title: 'Sound',
        subtitle: 'Dice rolling sound effects',
        trailing: Switch(
          value: controller.soundEnabled.value,
          onChanged: controller.toggleSound,
          activeThumbColor: AppColors.violet,
        ),
      ),
    );
  }

  // ================================================================
  // VIBRATION
  // ================================================================

  Widget _buildVibrationSetting() {
    return Obx(
      () => _buildSettingTile(
        icon: Icons.vibration_rounded,
        title: 'Vibration',
        subtitle: 'Haptic feedback when rolling',
        trailing: Switch(
          value: controller.vibrationEnabled.value,
          onChanged: controller.toggleVibration,
          activeThumbColor: AppColors.violet,
        ),
      ),
    );
  }

  // ================================================================
  // DARK MODE
  // ================================================================

  // Widget _buildDarkModeSetting() {
  //   return Obx(
  //     () => _buildSettingTile(
  //       icon: Icons.dark_mode_rounded,
  //       title: 'Dark Mode',
  //       subtitle: 'Use the dark appearance',
  //       trailing: Switch(
  //         value: controller.darkModeEnabled.value,
  //         onChanged: controller.toggleDarkMode,
  //         activeThumbColor: AppColors.violet,
  //       ),
  //     ),
  //   );
  // }

  // ================================================================
  // ABOUT
  // ================================================================

  Widget _buildAboutSetting() {
    return _buildSettingTile(
      icon: Icons.info_outline_rounded,
      title: 'About',
      subtitle: 'About Dice App',
      trailing: const Icon(
        Icons.chevron_right_rounded,
        color: Colors.white38,
      ),
      onTap: _showAboutDialog,
    );
  }

  // ================================================================
  // SETTING TILE
  // ================================================================

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 13,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF121022),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: AppColors.purple.withValues(alpha: 0.14),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(13),
              ),
              child: Icon(
                icon,
                color: AppColors.violet,
                size: 20,
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
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 3),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),

            if (trailing != null) trailing,
          ],
        ),
      ),
    );
  }

  // ================================================================
  // LOGOUT
  // ================================================================

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton.icon(
        onPressed: _showLogoutDialog,
        icon: const Icon(
          Icons.logout_rounded,
          size: 19,
        ),
        label: const Text(
          'LOG OUT',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.redAccent,
          side: BorderSide(
            color: Colors.redAccent.withValues(alpha: 0.35),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  // ================================================================
  // EDIT PROFILE
  // ================================================================

  void _showEditNameDialog() {
    final nameController = TextEditingController(
      text: controller.playerName.value,
    );

    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF171229),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: TextField(
          controller: nameController,
          autofocus: true,
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: InputDecoration(
            hintText: 'Enter your name',
            hintStyle: const TextStyle(
              color: Colors.white38,
            ),
            filled: true,
            fillColor: const Color(0xFF0F0B20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
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
              controller.updatePlayerName(
                nameController.text,
              );

              Get.back();
            },
            child: const Text(
              'SAVE',
              style: TextStyle(
                color: AppColors.violet,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================================================================
  // ABOUT DIALOG
  // ================================================================

  void _showAboutDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF171229),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        title: const Text(
          'Dice App',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: const Text(
          'Roll the dice, play with friends, '
          'and enjoy every roll.',
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
  }

  // ================================================================
  // LOGOUT DIALOG
  // ================================================================

  void _showLogoutDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: const Color(0xFF171229),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
        ),
        title: const Text(
          'Log Out?',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: const Text(
          'Are you sure you want to log out?',
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
              Get.back();
            },
            child: const Text(
              'LOG OUT',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}