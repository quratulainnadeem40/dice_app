
import 'package:dice_app/core/dice_theme.dart';
import 'package:dice_app/core/theme/colors_custom.dart';
import 'package:dice_app/feature/roll_dice/controller/roll_dice_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RollDiceScreen extends GetView<RollDiceController> {
  const RollDiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ==================================================
          // BACKGROUND GLOW
          // ==================================================

          Positioned(
            top: -130,
            right: -100,
            child: _buildGlow(
              AppColors.purple.withOpacity(0.13),
              290,
            ),
          ),

          Positioned(
            bottom: 100,
            left: -150,
            child: _buildGlow(
              AppColors.blue.withOpacity(0.08),
              300,
            ),
          ),

          // ==================================================
          // MAIN CONTENT
          // ==================================================

          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),

                const SizedBox(height: 8),

                _buildHeading(),

                const SizedBox(height: 14),

                _buildPlayerSelector(),

                const SizedBox(height: 8),

                Expanded(
                  child: _buildDiceArea(),
                ),

                _buildRollButton(),

                const SizedBox(height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // BACKGROUND GLOW
  // ==========================================================

  Widget _buildGlow(
    Color color,
    double size,
  ) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          boxShadow: [
            BoxShadow(
              color: color,
              blurRadius: 100,
              spreadRadius: 20,
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // TOP BAR
  // ==========================================================

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        18,
        8,
        18,
        0,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.045),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 17,
              ),
            ),
          ),

          const Spacer(),

          const Text(
            'ROLL DICE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.4,
            ),
          ),

          const Spacer(),

          GestureDetector(
            onTap: () {
              Get.toNamed('/settings');
            },
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.045),
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.white.withOpacity(0.08),
                ),
              ),
              child: const Icon(
                Icons.settings_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // HEADING
  // ==========================================================

  Widget _buildHeading() {
    return Obx(
      () => Column(
        children: [
          Text(
            '${controller.playerCount.value} '
            '${controller.playerCount.value == 1 ? 'Player' : 'Players'}',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 27,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.4,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            controller.isRolling.value
                ? 'Rolling your dice...'
                : 'Choose players and roll',
            style: TextStyle(
              color: Colors.white.withOpacity(0.42),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // PLAYER SELECTOR
  // ==========================================================

  Widget _buildPlayerSelector() {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.045),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.075),
          ),
        ),
        child: Row(
          children: List.generate(
            7,
            (index) {
              final number = index + 1;

              final selected =
                  controller.playerCount.value == number;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.setPlayerCount(number);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 180,
                    ),
                    height: 42,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(11),
                      gradient: selected
                          ? const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.purple,
                                AppColors.violet,
                              ],
                            )
                          : null,
                      color: selected
                          ? null
                          : Colors.white.withOpacity(0.025),
                      border: Border.all(
                        color: selected
                            ? Colors.transparent
                            : Colors.white.withOpacity(0.06),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$number',
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Colors.white.withOpacity(0.62),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // DICE AREA
  // ==========================================================

  Widget _buildDiceArea() {
    return Obx(
      () {
        final count = controller.playerCount.value;

        // ----------------------------------------------------
        // 1 PLAYER
        // ----------------------------------------------------

        if (count == 1) {
          return Center(
            child: _buildPlayerDice(
              0,
              size: 155,
            ),
          );
        }

        // ----------------------------------------------------
        // 2 PLAYERS
        // ----------------------------------------------------

        if (count == 2) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildPlayerDice(
                  0,
                  size: 110,
                ),
                const SizedBox(width: 30),
                _buildPlayerDice(
                  1,
                  size: 110,
                ),
              ],
            ),
          );
        }

        // ----------------------------------------------------
        // 3 - 7 PLAYERS
        // ----------------------------------------------------

        return _buildBalancedPlayerLayout(count);
      },
    );
  }

  // ==========================================================
  // BALANCED LAYOUT
  //
  // 3 = 3
  // 4 = 2 + 2
  // 5 = 3 + 2
  // 6 = 3 + 3
  // 7 = 3 + 2 + 2
  // ==========================================================

  Widget _buildBalancedPlayerLayout(
    int count,
  ) {
    final rows = <List<int>>[];

    if (count == 3) {
      rows.add([0, 1, 2]);
    } else if (count == 4) {
      rows.add([0, 1]);
      rows.add([2, 3]);
    } else if (count == 5) {
      rows.add([0, 1, 2]);
      rows.add([3, 4]);
    } else if (count == 6) {
      rows.add([0, 1, 2]);
      rows.add([3, 4, 5]);
    } else if (count == 7) {
      rows.add([0, 1, 2]);
      rows.add([3, 4]);
      rows.add([5, 6]);
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(
        14,
        4,
        14,
        4,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: rows.map(
          (row) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 7,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: row.map(
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: _buildPlayerDice(
                        index,
                        size: _diceSize(count),
                      ),
                    );
                  },
                ).toList(),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  // ==========================================================
  // DICE SIZE
  // ==========================================================

  double _diceSize(int count) {
    switch (count) {
      case 3:
        return 88;

      case 4:
        return 84;

      case 5:
        return 76;

      case 6:
        return 70;

      case 7:
      default:
        return 68;
    }
  }

  // ==========================================================
  // PLAYER DICE
  // ==========================================================

  Widget _buildPlayerDice(
    int index, {
    required double size,
  }) {
    return Obx(
      () {
        final value = controller.diceValues[index];

        // Theme comes directly from the same RollDiceController.
        final DiceTheme theme =
            controller.selectedDiceTheme;

        return SizedBox(
          width: size + 34,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ===============================================
              // PLAYER LABEL
              // ===============================================

              Container(
                constraints: const BoxConstraints(
                  minWidth: 78,
                  maxWidth: 100,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 9,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: theme.glowColor.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.glowColor.withOpacity(0.18),
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'PLAYER ${index + 1}',
                    maxLines: 1,
                    style: TextStyle(
                      color: theme.glowColor,
                      fontSize: 8.5,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.7,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 8),

              // ===============================================
              // DICE
              // ===============================================

              AnimatedRotation(
                duration: const Duration(
                  milliseconds: 220,
                ),
                turns: controller.isRolling.value
                    ? 0.04
                    : 0,
                curve: Curves.easeOutBack,
                child: AnimatedScale(
                  duration: const Duration(
                    milliseconds: 220,
                  ),
                  scale: controller.isRolling.value
                      ? 0.92
                      : 1.0,
                  curve: Curves.easeOutBack,
                  child: _buildDiceFace(
                    value: value,
                    size: size,
                    theme: theme,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // DICE FACE
  // ==========================================================

  Widget _buildDiceFace({
    required int value,
    required double size,
    required DiceTheme theme,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          size * 0.20,
        ),

        // THEME COLORS
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: theme.colors,
        ),

        border: Border.all(
          color: Colors.white.withOpacity(0.85),
          width: 1.2,
        ),

        // PREMIUM SHADOW
        boxShadow: [
          BoxShadow(
            color: theme.glowColor.withOpacity(0.30),
            blurRadius: 20,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.38),
            blurRadius: 12,
            offset: const Offset(
              0,
              7,
            ),
          ),
        ],
      ),
      child: Stack(
        children: [
          // ================================================
          // TOP HIGHLIGHT
          // ================================================

          Positioned(
            top: size * 0.075,
            left: size * 0.11,
            child: Container(
              width: size * 0.34,
              height: size * 0.09,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.78),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          // ================================================
          // SOFT BOTTOM SHADE
          // ================================================

          Positioned(
            right: size * 0.05,
            bottom: size * 0.05,
            child: Container(
              width: size * 0.34,
              height: size * 0.16,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.04),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),

          // ================================================
          // VALUE
          // ================================================

          Center(
            child: controller.diceSides.value <= 6
                ? _buildDiceDots(
                    value: value,
                    size: size,
                  )
                : Text(
                    '$value',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size * 0.34,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DICE DOTS
  // ==========================================================

  Widget _buildDiceDots({
    required int value,
    required double size,
  }) {
    final positions = switch (value) {
      1 => [4],
      2 => [0, 8],
      3 => [0, 4, 8],
      4 => [0, 2, 6, 8],
      5 => [0, 2, 4, 6, 8],
      6 => [0, 2, 3, 5, 6, 8],
      _ => [4],
    };

    return SizedBox(
      width: size * 0.65,
      height: size * 0.65,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: (context, index) {
          if (!positions.contains(index)) {
            return const SizedBox.shrink();
          }

          return Center(
            child: Container(
              width: size * 0.105,
              height: size * 0.105,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF22232B),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.30),
                    blurRadius: size * 0.025,
                    offset: const Offset(
                      0,
                      1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ==========================================================
  // ROLL BUTTON
  // ==========================================================

 Widget _buildRollButton() {
  return Obx(
    () => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton.icon(
          onPressed: controller.isRolling.value
              ? null
              : () {
                  debugPrint('ROLL BUTTON PRESSED');
                  controller.rollAllDice();
                },
          icon: Icon(
            controller.isRolling.value
                ? Icons.sync_rounded
                : Icons.casino_rounded,
            color: Colors.white,
            size: 21,
          ),
          label: Text(
            controller.isRolling.value
                ? 'ROLLING...'
                : 'ROLL ALL DICE',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w900,
              letterSpacing: 0.9,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.purple,
            disabledBackgroundColor:
                AppColors.purple.withValues(alpha: 0.45),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ),
      ),
    ),
  );
}
}