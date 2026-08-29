import 'package:dice_app/core/routes/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dice_app/core/theme/theme_custom.dart';

void main() {
  runApp(const DiceApp());
}

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice App',
      theme: ThemeCustom.darkTheme, // Custom dark theme apply kar di gayi hai
      initialRoute: AppPages.INITIAL, // Variable case fix kar diya gaya hai
      getPages: AppPages.routes,
    );
  }
}