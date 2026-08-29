import 'package:dice_app/core/theme/textstyle_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/colors_custom.dart';
import '../controller/roll_dice_controller.dart';
import '../widgets/dice_card.dart';
import '../widgets/dice_result.dart';
import '../widgets/roll_button.dart';
import '../widgets/total_result_card.dart';


class RollDiceScreen extends GetView<RollDiceController> {
  const RollDiceScreen({Key? key}) : super(key: key);

  Color _getColorFromString(String colorName) {
    switch (colorName) {
      case 'blue':
        return AppColors.diceBlue;
      case 'orange':
        return AppColors.diceOrange;
      case 'red':
        return AppColors.diceRed;
      case 'green':
        return AppColors.diceGreen;
      case 'gray':
        return AppColors.diceGray;
      case 'purple':
      default:
        return AppColors.dicePurple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBg,
      appBar: AppBar(
        title: Obx(
          () => Text(
            '${controller.diceCount.value} Dice • ${controller.diceSides.value} Sides',
            style: AppTextStyles.headingMedium,
          ),
        ),
        backgroundColor: AppColors.darkBgSecondary,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Container(
            margin: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.borderColor),
            ),
            child: const Icon(Icons.arrow_back_rounded),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Main Dice Display
                Obx(
                  () => Center(
                    child: DiceCard(
                      result: controller.isRolling.value
                          ? null
                          : (controller.lastResult.isEmpty
                              ? null
                              : controller.rollTotal.value),
                      isRolling: controller.isRolling.value,
                      diceColor: _getColorFromString(
                        controller.selectedColor.value,
                      ),
                      size: 180,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Roll Button
                Obx(
                  () => RollButton(
                    onPressed: controller.rollDice,
                    isLoading: controller.isRolling.value,
                    label: 'ROLL DICE',
                  ),
                ),
                const SizedBox(height: 32),

                // Dice Results
                Obx(
                  () => controller.lastResult.isNotEmpty
                      ? Column(
                          children: [
                            DiceResult(
                              results: controller.lastResult.toList(),
                              diceColor: _getColorFromString(
                                controller.selectedColor.value,
                              ),
                              showAnimations: !controller.isRolling.value,
                            ),
                            const SizedBox(height: 20),
                            TotalResultCard(
                              total: controller.rollTotal.value,
                              results: controller.lastResult.toList(),
                            ),
                            const SizedBox(height: 32),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),

                // Dice Configuration
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBg,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dice Configuration',
                        style: AppTextStyles.headingSmall,
                      ),
                      const SizedBox(height: 16),

                      // Dice Count
                      _buildConfigRow(
                        label: 'Number of Dice',
                        value: controller.diceCount,
                        onIncrement: controller.incrementDiceCount,
                        onDecrement: controller.decrementDiceCount,
                      ),
                      const SizedBox(height: 16),

                      // Dice Sides
                      _buildConfigRow(
                        label: 'Number of Sides',
                        value: controller.diceSides,
                        onIncrement: controller.incrementDiceSides,
                        onDecrement: controller.decrementDiceSides,
                      ),
                      const SizedBox(height: 16),

                      // Dice Color
                      Text(
                        'Dice Theme / Color',
                        style: AppTextStyles.labelMedium,
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: controller.diceColors
                              .map(
                                (color) => GestureDetector(
                                  onTap: () =>
                                      controller.setDiceColor(color),
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color:
                                          _getColorFromString(color),
                                      borderRadius:
                                          BorderRadius.circular(12),
                                      border: Border.all(
                                        color: controller
                                                    .selectedColor
                                                    .value ==
                                                color
                                            ? AppColors
                                                .textPrimary
                                            : Colors.transparent,
                                        width: 2,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: _getColorFromString(
                                                  color)
                                              .withOpacity(0.3),
                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                    child: controller
                                                .selectedColor
                                                .value ==
                                            color
                                        ? const Icon(
                                            Icons.check,
                                            color: AppColors
                                                .textPrimary,
                                          )
                                        : null,
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Animation Speed
                      Text(
                        'Animation Speed',
                        style: AppTextStyles.labelMedium,
                      ),
                      const SizedBox(height: 12),
                      Obx(
                        () => Row(
                          children: [
                            Text(
                              'Slow',
                              style: AppTextStyles.bodySmall,
                            ),
                            Expanded(
                              child: Slider(
                                value: controller.animationSpeed.value,
                                min: 0.5,
                                max: 2.0,
                                divisions: 3,
                                onChanged: controller.setAnimationSpeed,
                              ),
                            ),
                            Text(
                              'Fast',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildConfigRow({
    required String label,
    required Rx<int> value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTextStyles.labelMedium,
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBgLight,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: onDecrement,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.remove_rounded,
                    size: 18,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Obx(
                  () => Text(
                    '${value.value}',
                    style: AppTextStyles.headingSmall,
                  ),
                ),
              ),
              GestureDetector(
                onTap: onIncrement,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: const Icon(
                    Icons.add_rounded,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}