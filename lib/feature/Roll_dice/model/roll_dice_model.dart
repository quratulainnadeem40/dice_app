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

  // State update karne ke liye copyWith method
  DiceModel copyWith({
    int? currentValue,
    int? sides,
    Color? color,
    bool? isRolling,
  }) {
    return DiceModel(
      id: this.id,
      currentValue: currentValue ?? this.currentValue,
      sides: sides ?? this.sides,
      color: color ?? this.color,
      isRolling: isRolling ?? this.isRolling,
    );
  }
}