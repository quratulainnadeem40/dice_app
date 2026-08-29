import 'package:flutter/material.dart';

class CustomDiceWidget extends StatelessWidget {
  final int value;
  final Color baseColor; // Har dice ka unique color

  const CustomDiceWidget({
    Key? key,
    required this.value,
    required this.baseColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      margin: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: baseColor,
        borderRadius: BorderRadius.circular(18), // Image jaisi 3D rounded shape
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            baseColor.withOpacity(0.9),
            baseColor,
            Colors.black.withOpacity(0.4), // 3D depth effect
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: baseColor.withOpacity(0.5),
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(
        child: Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}