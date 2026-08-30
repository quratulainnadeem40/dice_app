import 'package:flutter/material.dart';

class SettingsModel {
  // Session-only game state (Always resets to default on app start)
  int diceCount;
  int diceSides;

  // Persistent settings (Saved in Local Storage)
  Color diceColor;
  double animationSpeed;

  bool soundEnabled;
  double soundVolume;

  bool vibrationEnabled;
  double vibrationIntensity;

  int rollSoundDice;

  SettingsModel({
    this.diceCount = 1,
    this.diceSides = 6,
    // Default transparent set (Gradient mode)
    this.diceColor = Colors.transparent,
    this.animationSpeed = 0.5,
    this.soundEnabled = true,
    this.soundVolume = 0.6,
    this.vibrationEnabled = true,
    this.vibrationIntensity = 0.65,
    this.rollSoundDice = 1,
  });

  // Only persistent settings are saved to local storage
  Map<String, dynamic> toMap() {
    return {
      'diceColor': diceColor.toARGB32(),
      'animationSpeed': animationSpeed,
      'soundEnabled': soundEnabled,
      'soundVolume': soundVolume,
      'vibrationEnabled': vibrationEnabled,
      'vibrationIntensity': vibrationIntensity,
      'rollSoundDice': rollSoundDice,
    };
  }

  // Loading from saved data safely (diceCount & diceSides always default to 1 & 6)
  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      diceCount: 1, // Session default
      diceSides: 6, // Session default
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