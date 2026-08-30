
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
            child: Column(
              children: [
                _buildTopBar(),

                const SizedBox(height: 8),

                _buildHeading(controller),

                const SizedBox(height: 14),

                // ==================================================
                // NUMBER OF PLAYERS
                // ==================================================

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    child: Text(
                      'NUMBER OF PLAYERS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                _buildPlayerSelector(controller),

                const SizedBox(height: 14),

                // ==================================================
                // NUMBER OF DICE SIDES
                // ==================================================

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(
                      horizontal: 18,
                    ),
                    child: Text(
                      'NUMBER OF DICE SIDES',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight:
                            FontWeight.w800,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 7),

                _buildDiceSidesSelector(
                  controller,
                ),

                const SizedBox(height: 8),

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
            onTap: () => Get.back(),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: Colors.white.withValues(
                  alpha: 0.045,
                ),
                borderRadius:
                    BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ),
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
                color: Colors.white.withValues(
                  alpha: 0.045,
                ),
                borderRadius:
                    BorderRadius.circular(13),
                border: Border.all(
                  color: Colors.white.withValues(
                    alpha: 0.08,
                  ),
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

  Widget _buildHeading(
    RollDiceController controller,
  ) {
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
              color: Colors.white.withValues(
                alpha: 0.42,
              ),
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

  Widget _buildPlayerSelector(
    RollDiceController controller,
  ) {
    return Obx(
      () => Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 18,
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(
            alpha: 0.045,
          ),
          borderRadius:
              BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withValues(
              alpha: 0.075,
            ),
          ),
        ),
        child: Row(
          children: List.generate(
            7,
            (index) {
              final int number = index + 1;

              final bool selected =
                  controller.playerCount.value ==
                      number;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.setPlayerCount(
                      number,
                    );
                  },
                  child: AnimatedContainer(
                    duration:
                        const Duration(
                      milliseconds: 180,
                    ),
                    height: 42,
                    margin:
                        const EdgeInsets.symmetric(
                      horizontal: 2,
                    ),
                    decoration:
                        BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(
                        11,
                      ),
                      gradient: selected
                          ? const LinearGradient(
                              begin:
                                  Alignment.topLeft,
                              end: Alignment
                                  .bottomRight,
                              colors: [
                                AppColors.purple,
                                AppColors.violet,
                              ],
                            )
                          : null,
                      color: selected
                          ? null
                          : Colors.white
                              .withValues(
                              alpha: 0.025,
                            ),
                      border: Border.all(
                        color: selected
                            ? Colors.transparent
                            : Colors.white
                                .withValues(
                                alpha: 0.06,
                              ),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '$number',
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Colors.white
                                  .withValues(
                                  alpha: 0.62,
                                ),
                          fontSize: 13,
                          fontWeight:
                              FontWeight.w800,
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
  // DICE SIDES SELECTOR
  // ==========================================================

  Widget _buildDiceSidesSelector(
    RollDiceController controller,
  ) {
    return Obx(
      () {
        final int selectedSides =
            controller.diceSides.value;

        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          height: 52,
          padding:
              const EdgeInsets.symmetric(
            horizontal: 5,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withValues(
              alpha: 0.045,
            ),
            borderRadius:
                BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(
                alpha: 0.075,
              ),
            ),
          ),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics:
                const BouncingScrollPhysics(),
            padding:
                const EdgeInsets.symmetric(
              horizontal: 3,
            ),
            itemCount: 18,
            separatorBuilder:
                (context, index) {
              return const SizedBox(
                width: 4,
              );
            },
            itemBuilder:
                (context, index) {
              final int sides = index + 3;

              final bool isSelected =
                  selectedSides == sides;

              return GestureDetector(
                onTap: () {
                  controller.setDiceSides(
                    sides,
                  );
                },
                child: AnimatedContainer(
                  duration:
                      const Duration(
                    milliseconds: 180,
                  ),
                  width: 40,
                  margin:
                      const EdgeInsets.symmetric(
                    vertical: 5,
                  ),
                  decoration:
                      BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(
                      11,
                    ),
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [
                              AppColors.purple,
                              AppColors.violet,
                            ],
                          )
                        : null,
                    color: isSelected
                        ? null
                        : Colors.white
                            .withValues(
                            alpha: 0.025,
                          ),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : Colors.white
                              .withValues(
                              alpha: 0.06,
                            ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '$sides',
                      style: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : Colors.white
                                .withValues(
                                alpha: 0.62,
                              ),
                        fontSize: 13,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // ==========================================================
  // DICE AREA
  // ==========================================================

  Widget _buildDiceArea(
    BuildContext context,
    RollDiceController controller,
  ) {
    return Obx(
      () {
        final int count =
            controller.playerCount.value;

        if (count == 1) {
          return Center(
            child: _buildPlayerDice(
              context,
              0,
              size: 155,
              controller: controller,
            ),
          );
        }

        if (count == 2) {
          final double screenWidth =
              MediaQuery.sizeOf(context).width;

          final double availableWidth =
              screenWidth - 56;

          final double size =
              ((availableWidth - 30) / 2)
                  .clamp(85.0, 120.0);

          return Center(
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
                const SizedBox(width: 20),
                _buildPlayerDice(
                  context,
                  1,
                  size: size,
                  controller: controller,
                ),
              ],
            ),
          );
        }

        return _buildBalancedPlayerLayout(
          count,
          context,
          controller,
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
    RollDiceController controller,
  ) {
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
    }

    final double screenWidth =
        MediaQuery.sizeOf(context).width;

    return Center(
      child: SingleChildScrollView(
        physics:
            const BouncingScrollPhysics(),
        padding:
            const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 8,
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
              );

              return Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: row.map(
                    (index) {
                      return Padding(
                        padding:
                            const EdgeInsets.symmetric(
                          horizontal: 5,
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
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  // ==========================================================
  // RESPONSIVE DICE SIZE
  // ==========================================================

  double _responsiveDiceSize({
    required int count,
    required int rowCount,
    required double screenWidth,
  }) {
    const double horizontalPadding = 10.0;
    const double safetySpace = 12.0;

    final double availableWidth =
        screenWidth -
        horizontalPadding -
        safetySpace;

    final double calculatedSize =
        (availableWidth / rowCount) -
        34 -
        10;

    double maxSize;

    switch (count) {
      case 3:
        maxSize = 105;
        break;

      case 4:
        maxSize = 100;
        break;

      case 5:
        maxSize = 95;
        break;

      case 6:
        maxSize = 90;
        break;

      case 7:
      default:
        maxSize = 85;
        break;
    }

    return calculatedSize.clamp(
      55.0,
      maxSize,
    );
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

        return SizedBox(
          width: size + 34,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ==================================================
              // PLAYER NAME
              // ==================================================

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

              // ==================================================
              // DICE
              // ==================================================

              AnimatedScale(
                duration:
                    const Duration(
                  milliseconds: 250,
                ),
                scale:
                    controller.isRolling.value
                        ? 0.88
                        : 1.0,
                curve:
                    Curves.easeOutBack,
                child: _buildDiceFace(
                  value: value,
                  size: size,
                  theme: theme,
                  controller: controller,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==========================================================
  // 3D DICE FACE
  // ==========================================================

  Widget _buildDiceFace({
    required int value,
    required double size,
    required DiceTheme theme,
    required RollDiceController controller,
  }) {
    return AnimatedContainer(
      duration:
          const Duration(milliseconds: 250),
      curve: Curves.easeOutBack,
      child: Transform(
        transform: Matrix4.identity()
          ..setEntry(
            3,
            2,
            0.0008,
          )
          ..rotateX(
            controller.isRolling.value
                ? 0.25
                : 0.05,
          )
          ..rotateY(
            controller.isRolling.value
                ? -0.30
                : -0.05,
          )
          ..rotateZ(
            controller.isRolling.value
                ? 0.10
                : 0.0,
          ),
        alignment: Alignment.center,
        child: Container(
          width: size,
          height: size,
          decoration:
              BoxDecoration(
            borderRadius:
                BorderRadius.circular(
              size * 0.22,
            ),
            gradient: LinearGradient(
              begin:
                  Alignment.topLeft,
              end:
                  Alignment.bottomRight,
              colors: theme.colors,
            ),
            border: Border.all(
              color:
                  Colors.white.withValues(
                alpha: 0.85,
              ),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color:
                    theme.glowColor.withValues(
                  alpha: 0.40,
                ),
                blurRadius: 14,
                spreadRadius: 1,
                offset:
                    const Offset(-2, 4),
              ),
              BoxShadow(
                color:
                    Colors.black.withValues(
                  alpha: 0.40,
                ),
                blurRadius: 8,
                offset:
                    const Offset(3, 5),
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
                  decoration:
                      BoxDecoration(
                    color:
                        Colors.white.withValues(
                      alpha: 0.75,
                    ),
                    borderRadius:
                        BorderRadius.circular(
                      50,
                    ),
                  ),
                ),
              ),

              // ==================================================
              // DICE VALUE
              // ==================================================

              Center(
                child:
                    controller.diceSides.value <=
                            6
                        ? _buildDiceDots(
                            value: value,
                            size: size,
                          )
                        : Text(
                            '$value',
                            style:
                                TextStyle(
                              color:
                                  Colors.white,
                              fontSize:
                                  size * 0.34,
                              fontWeight:
                                  FontWeight.w900,
                              shadows: [
                                Shadow(
                                  color: Colors
                                      .black
                                      .withValues(
                                    alpha: 0.45,
                                  ),
                                  offset:
                                      const Offset(
                                    2,
                                    2,
                                  ),
                                  blurRadius:
                                      3,
                                ),
                              ],
                            ),
                          ),
              ),
            ],
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
                  : 'ROLL ALL DICE',
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