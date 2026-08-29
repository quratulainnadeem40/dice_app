import 'package:flutter/material.dart';
import 'colors_custom.dart';

class TextStylesCustom {
  static const TextStyle titleBold = TextStyle(
    color: ColorsCustom.textPrimary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subTitle = TextStyle(
    color: ColorsCustom.textSecondary,
    fontSize: 14,
  );

  static const TextStyle bodyText = TextStyle(
    color: ColorsCustom.textPrimary,
    fontSize: 14,
  );
}