import 'package:flutter/material.dart';

class SettingsModel {
  int diceCount;
  int diceSides;
  Color diceColor;
  double animationSpeed;

  bool soundEnabled;
  double soundVolume;

  bool vibrationEnabled;
  double vibrationIntensity;

  int rollSoundDice;

  SettingsModel({
    this.diceCount = 3,
    this.diceSides = 6,
    this.diceColor = const Color(0xFF8B2CFF),
    this.animationSpeed = 0.5,
    this.soundEnabled = true,
    this.soundVolume = 0.6,
    this.vibrationEnabled = true,
    this.vibrationIntensity = 0.65,
    this.rollSoundDice = 1,
  });
}