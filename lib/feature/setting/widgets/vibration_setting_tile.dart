import 'package:flutter/material.dart';

class VibrationSettingTile extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  const VibrationSettingTile({
    Key? key,
    required this.isEnabled,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        activeColor: const Color(0xFF8B5CF6),
        title: const Text('Vibration', style: TextStyle(color: Colors.white)),
        value: isEnabled,
        onChanged: onChanged,
      ),
    );
  }
}