import 'package:flutter/material.dart';

class SettingsModel {
  int diceCount;
  int diceSides;
  Color diceColor;
  double animationSpeed;
  bool soundEnabled;
  bool vibrationEnabled;

  SettingsModel({
    this.diceCount = 1,
    this.diceSides = 6,
    this.diceColor = const Color(0xFF8B5CF6),
    this.animationSpeed = 0.5,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
  });
}