import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class VibrationSettingTile extends StatelessWidget {
  const VibrationSettingTile({super.key});

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
          children: [
            Row(
              children: [
                const Icon(
                  Icons.vibration_rounded,
                  color: Color(0xFFB43DFF),
                  size: 28,
                ),

                const SizedBox(width: 14),

                const Expanded(
                  child: Text(
                    'Vibration',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),

                Switch(
                  value:
                      controller.vibrationEnabled.value,
                  onChanged:
                      controller.toggleVibration,
                  activeColor: Colors.white,
                  activeTrackColor:
                      const Color(0xFFA52DFF),
                  inactiveTrackColor:
                      const Color(0xFF35385A),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                const Icon(
                  Icons.vibration_rounded,
                  color: Color(0xFFB43DFF),
                  size: 21,
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor:
                          const Color(0xFFA52DFF),
                      inactiveTrackColor:
                          const Color(0xFF282B54),
                      thumbColor: Colors.white,
                      trackHeight: 4,
                    ),
                    child: Slider(
                      value: controller
                          .vibrationIntensity.value,
                      onChanged:
                          controller.vibrationEnabled.value
                              ? controller
                                  .setVibrationIntensity
                              : null,
                    ),
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