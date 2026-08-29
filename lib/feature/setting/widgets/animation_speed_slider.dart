import 'package:flutter/material.dart';

class AnimationSpeedSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const AnimationSpeedSlider({
    Key? key,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1A34),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Slider(
            value: value,
            activeColor: const Color(0xFF8B5CF6),
            inactiveColor: Colors.white12,
            onChanged: onChanged,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Slow', style: TextStyle(color: Colors.white38, fontSize: 12)),
                Text('Fast', style: TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}