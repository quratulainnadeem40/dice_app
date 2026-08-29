import 'package:flutter/material.dart';

class ResponsiveHelper {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double textScaleFactor;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
    textScaleFactor = _mediaQueryData.textScaleFactor;
  }

  // Device type detection
  static bool get isPhone => screenWidth < 600;
  static bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  static bool get isLandscape =>
      _mediaQueryData.orientation == Orientation.landscape;
  static bool get isPortrait =>
      _mediaQueryData.orientation == Orientation.portrait;

  // Responsive sizing
  static double hp(double percentage) => blockSizeVertical * percentage;
  static double wp(double percentage) => blockSizeHorizontal * percentage;

  // Padding and margins
  static EdgeInsets paddingAll(double value) =>
      EdgeInsets.all(wp(value));

  static EdgeInsets paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) =>
      EdgeInsets.symmetric(
        horizontal: wp(horizontal),
        vertical: hp(vertical),
      );

  // Font sizes
  static double getFontSize(double baseSize) {
    if (isPhone) return baseSize * 0.9;
    if (isTablet) return baseSize * 1.1;
    return baseSize;
  }

  // Border radius
  static BorderRadius borderRadius(double radius) =>
      BorderRadius.circular(wp(radius));

  // Spacing
  static SizedBox verticalSpace(double height) =>
      SizedBox(height: hp(height));

  static SizedBox horizontalSpace(double width) =>
      SizedBox(width: wp(width));
}