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
    // Default transparent set kiya hai (Default Multi-Color mode ke liye)
    this.diceColor = Colors.transparent,
    this.animationSpeed = 0.5,
    this.soundEnabled = true,
    this.soundVolume = 0.6,
    this.vibrationEnabled = true,
    this.vibrationIntensity = 0.65,
    this.rollSoundDice = 1,
  });

  // Color Value to ARGB int conversion for saving
  Map<String, dynamic> toMap() {
    return {
      'diceCount': diceCount,
      'diceSides': diceSides,
      'diceColor': diceColor.value,
      'animationSpeed': animationSpeed,
      'soundEnabled': soundEnabled,
      'soundVolume': soundVolume,
      'vibrationEnabled': vibrationEnabled,
      'vibrationIntensity': vibrationIntensity,
      'rollSoundDice': rollSoundDice,
    };
  }

  // Loading from saved data safely
  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      diceCount: map['diceCount'] ?? 3,
      diceSides: map['diceSides'] ?? 6,
      diceColor: map['diceColor'] != null
          ? Color(map['diceColor'])
          : Colors.transparent,
      animationSpeed: (map['animationSpeed'] ?? 0.5).toDouble(),
      soundEnabled: map['soundEnabled'] ?? true,
      soundVolume: (map['soundVolume'] ?? 0.6).toDouble(),
      vibrationEnabled: map['vibrationEnabled'] ?? true,
      vibrationIntensity: (map['vibrationIntensity'] ?? 0.65).toDouble(),
      rollSoundDice: map['rollSoundDice'] ?? 1,
    );
  }
}