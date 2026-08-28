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
              AppColors.purple.withOpacity(0.16),
              290,
            ),
          ),

          Positioned(
            bottom: 80,
            left: -150,
            child: _buildGlow(
              AppColors.blue.withOpacity(0.10),
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

                const SizedBox(height: 12),

                _buildHeading(),

                const SizedBox(height: 14),

                _buildPlayerSelector(),

                const SizedBox(height: 6),

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
            onTap: () => Get.back(),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.055),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.white.withOpacity(0.09),
                ),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),

          const Spacer(),

          const Text(
            'ROLL DICE',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.6,
            ),
          ),

          const Spacer(),

          // Keeps title centered
          const SizedBox(
            width: 44,
            height: 44,
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
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            controller.isRolling.value
                ? 'Rolling your dice...'
                : 'Choose players and roll',
            style: TextStyle(
              color: Colors.white.withOpacity(0.45),
              fontSize: 11,
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
          horizontal: 20,
        ),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.045),
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
          ),
        ),
        child: Row(
          children: List.generate(
            4,
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
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
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
                    ),
                    child: Center(
                      child: Text(
                        '$number',
                        style: TextStyle(
                          color: selected
                              ? Colors.white
                              : Colors.white54,
                          fontSize: 14,
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

        // ====================================================
        // 1 OR 2 PLAYERS
        // ====================================================

        if (count <= 2) {
          return Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                count,
                (index) {
                  return _buildPlayerDice(index);
                },
              ),
            ),
          );
        }

        // ====================================================
        // 3 OR 4 PLAYERS
        // ====================================================

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 4,
          ),
          itemCount: count,
          gridDelegate:
              const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 4,
            childAspectRatio: 1.20,
          ),
          itemBuilder: (context, index) {
            return _buildPlayerDice(index);
          },
        );
      },
    );
  }

  // ==========================================================
  // PLAYER DICE
  // ==========================================================

  Widget _buildPlayerDice(int index) {
    return Obx(
      () {
        final count = controller.playerCount.value;
        final value = controller.diceValues[index];

        double diceSize;

        if (count == 1) {
          diceSize = 155;
        } else if (count == 2) {
          diceSize = 112;
        } else {
          diceSize = 78;
        }

        const List<Color> diceColor1 = [
          Color(0xFFB14DFF),
          Color(0xFF3D9CFF),
          Color(0xFFFF9D42),
          Color(0xFF35D6A0),
        ];

        const List<Color> diceColor2 = [
          Color(0xFFFF4FD8),
          Color(0xFF4DE7FF),
          Color(0xFFFFD34D),
          Color(0xFF65FFB5),
        ];

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Player label
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 9,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: diceColor1[index].withOpacity(0.09),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: diceColor1[index].withOpacity(0.18),
                ),
              ),
              child: Text(
                'PLAYER ${index + 1}',
                style: TextStyle(
                  color: diceColor1[index],
                  fontSize: 7,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1,
                ),
              ),
            ),

            const SizedBox(height: 5),

            // Dice
            _buildDiceFace(
              value: value,
              size: diceSize,
              isRolling: controller.isRolling.value,
              color1: diceColor1[index],
              color2: diceColor2[index],
            ),
          ],
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
    required bool isRolling,
    required Color color1,
    required Color color2,
  }) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.25),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$value',
          style: TextStyle(
            fontSize: size > 100 ? 45 : 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // ==========================================================
  // ROLL BUTTON
  // ==========================================================

  Widget _buildRollButton() {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
            onPressed: controller.isRolling.value
                ? null
                : controller.rollAllDice,
            icon: const Icon(
              Icons.casino_rounded,
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
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.purple,
              disabledBackgroundColor:
                  AppColors.purple.withOpacity(0.45),
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