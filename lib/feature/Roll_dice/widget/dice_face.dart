import 'package:flutter/material.dart';

class DiceFace extends StatelessWidget {
  final int value;
  final double size;
  final bool isRolling;
  final Color color1;
  final Color color2;

  const DiceFace(
    this.value,
    this.size,
    this.isRolling,
    this.color1,
    this.color2, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color1,
            color2,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          '$value',
          style: const TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}