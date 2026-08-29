import 'package:flutter/material.dart';

class DiceTheme {
  final String id;
  final String name;
  final List<Color> colors;
  final Color glowColor;

  const DiceTheme({
    required this.id,
    required this.name,
    required this.colors,
    required this.glowColor,
  });
}

class DiceThemes {
  DiceThemes._();

  // ==========================================================
  // PURPLE
  // ==========================================================

  static const purple = DiceTheme(
    id: 'purple',
    name: 'Purple',
    colors: [
      Color(0xFFB14DFF),
      Color(0xFFFF4FD8),
    ],
    glowColor: Color(0xFFB14DFF),
  );

  // ==========================================================
  // BLUE
  // ==========================================================

  static const blue = DiceTheme(
    id: 'blue',
    name: 'Blue',
    colors: [
      Color(0xFF3D9CFF),
      Color(0xFF4DE7FF),
    ],
    glowColor: Color(0xFF3D9CFF),
  );

  // ==========================================================
  // RED
  // ==========================================================

  static const red = DiceTheme(
    id: 'red',
    name: 'Red',
    colors: [
      Color(0xFFFF4B4B),
      Color(0xFFFF8A6B),
    ],
    glowColor: Color(0xFFFF4B4B),
  );

  // ==========================================================
  // GREEN
  // ==========================================================

  static const green = DiceTheme(
    id: 'green',
    name: 'Green',
    colors: [
      Color(0xFF23C483),
      Color(0xFF65FFB5),
    ],
    glowColor: Color(0xFF23C483),
  );

  // ==========================================================
  // ORANGE
  // ==========================================================

  static const orange = DiceTheme(
    id: 'orange',
    name: 'Orange',
    colors: [
      Color(0xFFFF8A30),
      Color(0xFFFFD34D),
    ],
    glowColor: Color(0xFFFF8A30),
  );

  // ==========================================================
  // PINK
  // ==========================================================

  static const pink = DiceTheme(
    id: 'pink',
    name: 'Pink',
    colors: [
      Color(0xFFFF4F9A),
      Color(0xFFFF82C0),
    ],
    glowColor: Color(0xFFFF4F9A),
  );

  // ==========================================================
  // CYAN
  // ==========================================================

  static const cyan = DiceTheme(
    id: 'cyan',
    name: 'Cyan',
    colors: [
      Color(0xFF00BCD4),
      Color(0xFF63F5FF),
    ],
    glowColor: Color(0xFF00BCD4),
  );

  // ==========================================================
  // ALL THEMES
  // ==========================================================

  static const List<DiceTheme> all = [
    purple,
    blue,
    red,
    green,
    orange,
    pink,
    cyan,
  ];

  // ==========================================================
  // FIND THEME
  // ==========================================================

  static DiceTheme getById(String id) {
    return all.firstWhere(
      (theme) => theme.id == id,
      orElse: () => purple,
    );
  }
}