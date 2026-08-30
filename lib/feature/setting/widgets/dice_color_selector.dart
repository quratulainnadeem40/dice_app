import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiceColorSelector extends StatelessWidget {
  const DiceColorSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF111437),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Added to prevent vertical unbounded height
        children: [
          // TITLE
          const Text(
            'Dice Theme / Color',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 14),

          // COLORS - Constrained Scroll Area
          Obx(
            () => SizedBox(
              height: 46, // Fixed height for items + shadow/border room
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: controller.diceColors.map(
                    (color) {
                      final bool isMultiColorOption =
                          color == Colors.transparent;
                      final bool selected =
                          controller.diceColor.value == color;

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            controller.selectDiceColor(color);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            height: 42,
                            width: 42,
                            decoration: BoxDecoration(
                              color: isMultiColorOption ? null : color,
                              gradient: isMultiColorOption
                                  ? const LinearGradient(
                                      colors: [
                                        Color(0xFF8B2CFF),
                                        Color(0xFF087FF5),
                                        Color(0xFFFF3D4F),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                  : null,
                              borderRadius: BorderRadius.circular(10),
                              border: selected
                                  ? Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    )
                                  : null,
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: isMultiColorOption
                                            ? const Color(0xFF8B2CFF)
                                                .withValues(alpha: 0.65)
                                            : color.withValues(alpha: 0.65),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Center(
                              child: selected
                                  ? const Icon(
                                      Icons.check_rounded,
                                      color: Colors.white,
                                      size: 24,
                                    )
                                  : (isMultiColorOption
                                      ? const Icon(
                                          Icons.palette_rounded,
                                          color: Colors.white70,
                                          size: 20,
                                        )
                                      : null),
                            ),
                          ),
                        ),
                      );
                    },
                  ).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}