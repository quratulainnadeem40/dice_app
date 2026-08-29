import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';
import '../controller/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.menu),
        title: const Text('DICE ROLLER', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: CustomColors.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: const [
                Icon(Icons.monetization_on, color: Colors.amber, size: 18),
                SizedBox(width: 4),
                Text('1250', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const SizedBox(height: 20),
          
          // Glowing Neon Dice Interactive Target
          GestureDetector(
            onTap: controller.rollSingleDice,
            child: Obx(
              () => Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: CustomColors.primaryPurple,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: CustomColors.primaryNeon.withOpacity(0.6),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    '${controller.diceValue.value}',
                    style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          
          Obx(() => Text(
            controller.isRolled.value ? "YOU ROLLED\n${controller.diceValue.value}" : "TAP THE DICE TO ROLL",
            textAlign: TextAlign.center,
            style: const TextStyle(color: CustomColors.textSecondary, fontSize: 16, fontWeight: FontWeight.w600),
          )),

          // Bottom Stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              children: [
                Expanded(child: _buildStatCard("Last Result", "${controller.diceValue.value}")),
                const SizedBox(width: 16),
                Expanded(child: _buildStatCard("Total Rolls", "${controller.totalRolls.value}")),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: CustomColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: CustomColors.textSecondary, fontSize: 12)),
          const SizedBox(height: 6),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}