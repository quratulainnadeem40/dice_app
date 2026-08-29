import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';
import '../controller/roll_dice_controller.dart';

class RollDiceScreen extends StatelessWidget {
  const RollDiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RollDiceController());

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('ROLL DICE', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Obx(() => Text(
                '${controller.numberOfDice.value} Dice • ${controller.numberOfSides.value} Sides',
                style: const TextStyle(color: CustomColors.textSecondary, fontSize: 14),
              )),
              const Spacer(),
              
              // Dynamic Multi-Dice Container Grid
              Obx(() {
                if (controller.isRolling.value) {
                  return const Text(
                    'Rolling...',
                    style: TextStyle(color: CustomColors.textSecondary, fontSize: 18),
                  );
                }
                return Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16,
                  runSpacing: 16,
                  children: List.generate(
                    controller.diceResults.length,
                    (index) => _buildDiceFace(controller.diceResults[index], index),
                  ),
                );
              }),

              const Spacer(),

              // Roll Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: controller.rollDice,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.primaryPurple,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
                    elevation: 8,
                    shadowColor: CustomColors.primaryNeon.withOpacity(0.5),
                  ),
                  child: const Text('ROLL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
              ),

              const SizedBox(height: 20),

              // Results Sum Bar
              Obx(() => Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: CustomColors.surface,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Text('Results', style: TextStyle(color: CustomColors.textSecondary)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: controller.diceResults.map((val) => Container(
                            margin: const EdgeInsets.only(right: 6),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: CustomColors.primaryPurple,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text('$val', style: const TextStyle(fontWeight: FontWeight.bold)),
                          )).toList(),
                        ),
                      ),
                    ),
                    Text(
                      '= ${controller.totalSum}',
                      style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDiceFace(int value, int index) {
    final colors = [
      CustomColors.primaryPurple,
      CustomColors.accentBlue,
      CustomColors.accentOrange,
      CustomColors.accentGreen,
      CustomColors.accentRed
    ];
    final color = colors[index % colors.length];

    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: Center(
        child: Text(
          '$value',
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }
}