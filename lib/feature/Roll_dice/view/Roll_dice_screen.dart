import 'package:dice_app/feature/setting/view/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/roll_dice_controller.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.to(() => const SettingsScreen()),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
        child: Column(
          children: [
            Obx(() => Text(
                  '${controller.numberOfDice.value} Dice • ${controller.numberOfSides.value} Sides',
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                )),
            const Spacer(),
            
            // Dice View Display (Grid/Wrap for dynamic count)
            Obx(() => Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: controller.diceList.map((dice) {
                    return Container(
                      width: controller.numberOfDice.value > 2 ? 80 : 120,
                      height: controller.numberOfDice.value > 2 ? 80 : 120,
                      decoration: BoxDecoration(
                        color: dice.color,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: dice.color.withOpacity(0.5),
                            blurRadius: 15,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Center(
                        child: Text(
                          '${dice.currentValue}',
                          style: TextStyle(
                            fontSize: controller.numberOfDice.value > 2 ? 36 : 54,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                )),

            const Spacer(),

            // Roll Action Button
            Obx(() => ElevatedButton(
                  onPressed: controller.isRolling.value ? null : () => controller.rollDice(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    controller.isRolling.value ? 'Rolling...' : 'ROLL',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                )),

            const SizedBox(height: 30),

            // Bottom Results Display Card
            Obx(() => Row(
                  children: [
                    Expanded(
                      child: _buildResultBox('Last Result', '${controller.lastResult.value}'),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: _buildResultBox('Total', '${controller.totalSum}'),
                    ),
                  ],
                )),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildResultBox(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.white54, fontSize: 12)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}