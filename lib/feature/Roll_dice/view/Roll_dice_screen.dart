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
      backgroundColor: const Color(0xFF0F0B1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('ROLL DICE', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Obx(() => DiceSettingsPreview(
                    diceCount: controller.diceList.length,
                    sides: controller.diceList.isNotEmpty ? controller.diceList.first.sides : 6,
                  )),
              const Spacer(),
              Obx(() => Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: controller.diceList.map((dice) => DiceCard(dice: dice)).toList(),
                  )),
              const Spacer(),
              Obx(() => TotalResultCard(total: controller.totalSum.value)),
              const SizedBox(height: 20),
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