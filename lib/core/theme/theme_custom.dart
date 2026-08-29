import 'package:flutter/material.dart';
import 'colors_custom.dart';

class ThemeCustom {
  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: ColorsCustom.background,
      primaryColor: ColorsCustom.primary,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: ColorsCustom.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}