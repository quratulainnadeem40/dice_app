import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AnimationSpeedSlider extends StatelessWidget {
  const AnimationSpeedSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SettingsController>();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF111437),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Animation Speed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 5),

            Row(
              children: [
                const Text(
                  'Slow',
                  style: TextStyle(
                    color: Color(0xFFB8BAD0),
                    fontSize: 12,
                  ),
                ),

                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor:
                          const Color(0xFFA92BFF),
                      inactiveTrackColor:
                          const Color(0xFF282B54),
                      thumbColor: Colors.white,
                      overlayColor:
                          const Color(0xFFA92BFF)
                              .withValues(alpha: 0.15),
                      trackHeight: 5,
                    ),
                    child: Slider(
                      value: controller.animationSpeed.value,
                      min: 0,
                      max: 1,
                      onChanged:
                          controller.setAnimationSpeed,
                    ),
                  ),
                ),

                const Text(
                  'Fast',
                  style: TextStyle(
                    color: Color(0xFFB8BAD0),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}