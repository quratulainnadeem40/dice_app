import 'package:flutter/material.dart';

class DiceModel {
  final int id;
  int currentValue;
  final int sides;
  final Color color;
  bool isRolling;

  DiceModel({
    required this.id,
    this.currentValue = 1,
    this.sides = 6,
    this.color = const Color(0xFF8B5CF6),
    this.isRolling = false,
  });
}