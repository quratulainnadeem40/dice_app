
import 'package:dice_app/core/dice_theme.dart';
import 'package:dice_app/core/theme/custom_color.dart';
import 'package:dice_app/feature/Roll_dice/controller/roll_disc_controller.dart';
import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RollDiceScreen extends StatelessWidget {
  const RollDiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RollDiceController controller =
        Get.isRegistered<RollDiceController>()
            ? Get.find<RollDiceController>()
            : Get.put(RollDiceController());

    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          controller.stopVoice();
        }
      },
      child: Scaffold(
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
                AppColors.purple.withValues(alpha: 0.13),
                290,
              ),
            ),

            Positioned(
              bottom: 100,
              left: -150,
              child: _buildGlow(
                AppColors.blue.withValues(alpha: 0.08),
                300,
              ),
            ),

            // ==================================================
            // MAIN CONTENT
            // ==================================================

            SafeArea(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 700,
                  ),
                  child: Column(
                    children: [
                      _buildTopBar(controller),

                      const SizedBox(height: 10),

                      // ==================================================
                      // PLAYERS & SIDES DROPDOWNS
                      // ==================================================

                      _buildDropdownSelectors(controller),

                      const SizedBox(height: 10),

                      // ==================================================
                      // DICE AREA
                      // ==================================================

                      Expanded(
                        child: _buildDiceArea(
                          context,
                          controller,
                        ),
                      ),

                      // ==================================================
                      // ROLL BUTTON
                      // ==================================================

                      _buildRollButton(controller),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
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

  Widget _buildTopBar(RollDiceController controller) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        8,
        16,
        0,
      ),
      child: Row(
        children: [
          // BACK BUTTON
          GestureDetector(
            onTap: () {
              controller.stopVoice();
              Get.back();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.045,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),

          const SizedBox(width: 8),

          // TITLE
          Expanded(
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: const Text(
                  'ROLL DICE',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 8),

          // ======================================================
          // SOUND TOGGLE BUTTON
          // ======================================================
          Obx(() {
            final bool isSoundOn =
                controller.settingsController.soundEnabled.value;

            return GestureDetector(
              onTap: () {
                controller.toggleSound();
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isSoundOn
                      ? AppColors.purple.withValues(alpha: 0.25)
                      : Colors.white.withValues(alpha: 0.045),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSoundOn
                        ? AppColors.violet.withValues(alpha: 0.55)
                        : Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: Icon(
                  isSoundOn
                      ? Icons.volume_up_rounded
                      : Icons.volume_off_rounded,
                  color: isSoundOn ? AppColors.violet : Colors.white54,
                  size: 18,
                ),
              ),
            );
          }),

          const SizedBox(width: 6),

          // ======================================================
          // HISTORY BUTTON
          // ======================================================
          GestureDetector(
            onTap: () {
              controller.stopVoice();
              Get.toNamed('/history');
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.045,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ),
                ),
              ),
              child: const Icon(
                Icons.history_rounded,
                color: Colors.white,
                size: 19,
              ),
            ),
          ),

          const SizedBox(width: 6),

          // ======================================================
          // SETTINGS BUTTON
          // ======================================================
          GestureDetector(
            onTap: () {
              controller.stopVoice();
              Get.toNamed('/settings');
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.045,
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ),
                ),
              ),
              child: const Icon(
                Icons.settings_rounded,
                color: Colors.white,
                size: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }


  // ==========================================================
  // PLAYERS & SIDES DROPDOWNS
  // ==========================================================

  Widget _buildDropdownSelectors(RollDiceController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          // ======================================================
          // PLAYERS DROPDOWN
          // ======================================================

          Expanded(
            child: Obx(
              () => Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.purple.withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: controller.playerCount.value,
                    dropdownColor: const Color(0xFF181238),
                    borderRadius: BorderRadius.circular(16),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.violet,
                      size: 20,
                    ),
                    isExpanded: true,
                    items: List.generate(8, (index) {
                      final int count = index + 1;
                      final bool isSelected =
                          count == controller.playerCount.value;

                      return DropdownMenuItem<int>(
                        value: count,
                        child: Row(
                          children: [
                            Icon(
                              count == 1
                                  ? Icons.person_rounded
                                  : Icons.people_alt_rounded,
                              color: isSelected
                                  ? AppColors.violet
                                  : Colors.white70,
                              size: 17,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                '$count ${count == 1 ? 'Player' : 'Players'}',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        controller.setPlayerCount(value);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // ======================================================
          // SIDES DROPDOWN
          // ======================================================

          Expanded(
            child: Obx(
              () => Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.purple.withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    value: controller.diceSides.value,
                    dropdownColor: const Color(0xFF181238),
                    borderRadius: BorderRadius.circular(16),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.violet,
                      size: 20,
                    ),
                    isExpanded: true,
                    items: List.generate(18, (index) {
                      final int sides = index + 3;
                      final bool isSelected =
                          sides == controller.diceSides.value;

                      return DropdownMenuItem<int>(
                        value: sides,
                        child: Row(
                          children: [
                            Icon(
                              Icons.casino_rounded,
                              color: isSelected
                                  ? AppColors.violet
                                  : Colors.white70,
                              size: 17,
                            ),
                            const SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'D$sides ($sides Sides)',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white70,
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w800
                                      : FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        controller.setDiceSides(value);
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==========================================================
  // DICE AREA (INCREASED SIZE & BALANCED SPACING)
  // ==========================================================

  Widget _buildDiceArea(
    BuildContext context,
    RollDiceController controller,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Obx(
          () {
            final int count =
                controller.playerCount.value;

            if (count == 1) {
              final double maxH = (constraints.maxHeight - 20).clamp(90.0, 230.0);
              final double maxW = (constraints.maxWidth - 40).clamp(90.0, 230.0);
              final double size = (maxH < maxW ? maxH : maxW).clamp(90.0, 230.0);

              return Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: _buildPlayerDice(
                    context,
                    0,
                    size: size,
                    controller: controller,
                  ),
                ),
              );
            }

            if (count == 2) {
              final double availableWidth =
                  constraints.maxWidth - 44;
              final double maxH = (constraints.maxHeight - 32).clamp(75.0, 165.0);
              final double maxW = ((availableWidth - 24) / 2).clamp(75.0, 165.0);
              final double size = (maxH < maxW ? maxH : maxW).clamp(75.0, 165.0);

              return Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: [
                      _buildPlayerDice(
                        context,
                        0,
                        size: size,
                        controller: controller,
                      ),
                      const SizedBox(width: 24),
                      _buildPlayerDice(
                        context,
                        1,
                        size: size,
                        controller: controller,
                      ),
                    ],
                  ),
                ),
              );
            }

            return _buildBalancedPlayerLayout(
              count,
              context,
              controller,
              availableHeight: constraints.maxHeight,
              availableWidth: constraints.maxWidth,
            );
          },
        );
      },
    );
  }

  // ==========================================================
  // BALANCED PLAYER LAYOUT
  // ==========================================================

  Widget _buildBalancedPlayerLayout(
    int count,
    BuildContext context,
    RollDiceController controller, {
    double? availableHeight,
    double? availableWidth,
  }) {
    final List<List<int>> rows = [];

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
    } else if (count == 8) {
      rows.add([0, 1, 2, 3]);
      rows.add([4, 5, 6, 7]);
    }

    final double screenWidth =
        availableWidth ?? MediaQuery.sizeOf(context).width;

    return Center(
      child: SingleChildScrollView(
        physics:
            const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.symmetric(
          vertical: 6,
          horizontal: 6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: rows.map(
            (row) {
              final double diceSize =
                  _responsiveDiceSize(
                count: count,
                rowCount: row.length,
                screenWidth: screenWidth,
                availableHeight: availableHeight,
                totalRows: rows.length,
              );

              return Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 4,
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment.center,
                    children: row.map(
                      (index) {
                        return Padding(
                          padding:
                              const EdgeInsets.symmetric(
                            horizontal: 4,
                          ),
                          child:
                              _buildPlayerDice(
                            context,
                            index,
                            size: diceSize,
                            controller:
                                controller,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  // ==========================================================
  // RESPONSIVE DICE SIZE (LARGER BOUNDS & SAFE MARGINS)
  // ==========================================================

  double _responsiveDiceSize({
    required int count,
    required int rowCount,
    required double screenWidth,
    double? availableHeight,
    int totalRows = 1,
  }) {
    const double horizontalPadding = 20.0;

    final double availableWidth =
        screenWidth - horizontalPadding;

    final double calculatedSize =
        (availableWidth / rowCount) - 38;

    double maxSize;

    switch (count) {
      case 3:
        maxSize = 125;
        break;

      case 4:
        maxSize = 120;
        break;

      case 5:
        maxSize = 110;
        break;

      case 6:
        maxSize = 105;
        break;

      case 7:
        maxSize = 98;
        break;

      case 8:
      default:
        maxSize = 90;
        break;
    }

    double size = calculatedSize.clamp(
      45.0,
      maxSize,
    );

    if (availableHeight != null && totalRows > 0) {
      final double maxRowHeight = (availableHeight - 16) / totalRows;
      final double heightConstrainedSize = maxRowHeight - 42;
      if (heightConstrainedSize > 45 && heightConstrainedSize < size) {
        size = heightConstrainedSize;
      }
    }

    return size.clamp(50.0, maxSize);
  }

  // ==========================================================
  // PLAYER DICE THEME
  // ==========================================================

  DiceTheme _getPlayerTheme(
    int index,
    RollDiceController controller,
  ) {
    final SettingsController settings =
        controller.settingsController;

    if (settings.isMultiColor) {
      final List<DiceTheme> themes =
          DiceThemes.all;

      if (themes.isEmpty) {
        return controller.selectedDiceTheme.value;
      }

      return themes[index % themes.length];
    }

    return controller.selectedDiceTheme.value;
  }

  // ==========================================================
  // PLAYER DICE
  // ==========================================================

  Widget _buildPlayerDice(
    BuildContext context,
    int index, {
    required double size,
    required RollDiceController controller,
  }) {
    return Obx(
      () {
        if (index >=
            controller.diceValues.length) {
          return const SizedBox.shrink();
        }

        final int value =
            controller.diceValues[index];

        final DiceTheme theme =
            _getPlayerTheme(
          index,
          controller,
        );

        final bool showName = controller.playerCount.value > 1;

        return SizedBox(
          width: size + 34,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ==================================================
              // PLAYER NAME (Only when multiple players)
              // ==================================================

              if (showName) ...[
                GestureDetector(
                  onTap: () {
                    controller.editPlayerName(
                      context,
                      index,
                    );
                  },
                  child: Container(
                    constraints:
                        const BoxConstraints(
                      minWidth: 78,
                      maxWidth: 100,
                    ),
                    padding:
                        const EdgeInsets.symmetric(
                      horizontal: 9,
                      vertical: 5,
                    ),
                    decoration:
                        BoxDecoration(
                      color: theme.glowColor
                          .withValues(
                        alpha: 0.08,
                      ),
                      borderRadius:
                          BorderRadius.circular(
                        20,
                      ),
                      border: Border.all(
                        color: theme.glowColor
                            .withValues(
                          alpha: 0.18,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisSize:
                          MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            controller
                                .getPlayerName(
                              index,
                            )
                                .toUpperCase(),
                            maxLines: 1,
                            overflow:
                                TextOverflow.ellipsis,
                            textAlign:
                                TextAlign.center,
                            style: TextStyle(
                              color:
                                  theme.glowColor,
                              fontSize: 8.5,
                              fontWeight:
                                  FontWeight.w900,
                              letterSpacing: 0.7,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.edit_rounded,
                          color:
                              theme.glowColor,
                          size: 9,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
              ],

              // ==================================================
              // DICE
              // ==================================================

              _buildDiceFace(
                index: index,
                value: value,
                size: size,
                theme: theme,
                controller: controller,
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // DICE FACE (CLEAN 2D)
  // ==========================================================

  Widget _buildDiceFace({
    required int index,
    required int value,
    required double size,
    required DiceTheme theme,
    required RollDiceController controller,
  }) {
    final bool isDiceRolling = controller.isDiceRolling(index);

    return GestureDetector(
      onTap: () => controller.rollSingleDice(index),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 180),
          scale: isDiceRolling ? 0.92 : 1.0,
          curve: Curves.easeInOut,
          child: Container(
            width: size,
            height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            size * 0.22,
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: theme.colors,
          ),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.85,
            ),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.glowColor.withValues(
                alpha: 0.35,
              ),
              blurRadius: 16,
              spreadRadius: 1,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withValues(
                alpha: 0.30,
              ),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // ==================================================
            // HIGHLIGHT
            // ==================================================

            Positioned(
              top: size * 0.07,
              left: size * 0.10,
              child: Container(
                width: size * 0.35,
                height: size * 0.09,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(
                    alpha: 0.75,
                  ),
                  borderRadius: BorderRadius.circular(
                    50,
                  ),
                ),
              ),
            ),

            // ==================================================
            // DICE VALUE
            // ==================================================

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
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(
                              alpha: 0.45,
                            ),
                            offset: const Offset(
                              2,
                              2,
                            ),
                            blurRadius: 3,
                          ),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    ),
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
    final List<int> positions = switch (value) {
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
        physics:
            const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: 9,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder:
            (context, index) {
          if (!positions.contains(index)) {
            return const SizedBox.shrink();
          }

          return Center(
            child: Container(
              width: size * 0.105,
              height: size * 0.105,
              decoration:
                  const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF22232B),
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

  Widget _buildRollButton(
    RollDiceController controller,
  ) {
    return Obx(
      () => Padding(
        padding:
            const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed:
                controller.isRolling.value
                    ? null
                    : controller.rollAllDice,
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
                  : (controller.playerCount.value == 1
                      ? 'ROLL DICE'
                      : 'ROLL ALL DICE'),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.9,
              ),
            ),
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  AppColors.purple,
              disabledBackgroundColor:
                  AppColors.purple.withValues(
                alpha: 0.45,
              ),
              elevation: 0,
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}