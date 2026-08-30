import 'package:dice_app/core/routes/page_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/routes/app_routes.dart';

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
      initialRoute: AppRoutes.splash,
      getPages: AppPages.routes,
    );
  }
}