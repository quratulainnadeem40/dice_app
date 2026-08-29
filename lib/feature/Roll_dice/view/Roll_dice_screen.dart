import 'package:dice_app/feature/Roll_dice/widgets/dice_setting_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/roll_dice_controller.dart';
import '../widgets/dice_card.dart';
import '../widgets/roll_button.dart';
import '../widgets/total_result_card.dart';

class RollDiceScreen extends GetView<RollDiceController> {
  const RollDiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D0A1C), // Deep neon-dark background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'ROLL DICE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () => Get.toNamed('/settings'), // Settings view route
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            children: [
              // Dice count aur sides indicator
              Obx(() => DiceSettingsPreview(
                    diceCount: controller.diceList.length,
                    sides: controller.diceList.isNotEmpty ? controller.diceList.first.sides : 6,
                  )),
              
              const Spacer(),

              // Multi-color 3D Dice Wrap Grid
              Obx(() => Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: controller.diceList
                        .map((dice) => DiceCard(dice: dice))
                        .toList(),
                  )),

              const Spacer(),

              // Individual values summation badge (e.g., 2 + 5 + 6)
              Obx(() {
                if (controller.diceList.length <= 1) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: controller.diceList.asMap().entries.map((entry) {
                      int idx = entry.key;
                      var dice = entry.value;
                      return Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: dice.color.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: dice.color, width: 1),
                            ),
                            child: Text(
                              '${dice.currentValue}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (idx < controller.diceList.length - 1)
  const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6.0),
    child: Text(
      '+',
      style: TextStyle(
        color: Colors.white70, 
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
                        ],
                      );
                    }).toList(),
                  ),
                );
              }),

              // Total Result Display
              Obx(() => TotalResultCard(total: controller.totalSum.value)),

              const SizedBox(height: 16),

              // Roll Action Button
              Obx(() => RollButton(
                    onPressed: controller.rollDice,
                    isLoading: controller.isRolling.value,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}