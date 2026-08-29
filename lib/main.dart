import 'package:dice_app/feature/splash/binding/binding_splash.dart';

import 'package:dice_app/feature/splash/view/splash_screen.dart';
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

      getPages: [
        GetPage(
          name: AppRoutes.splash,
          page: () => const SplashScreen(),
          binding: SplashBinding(),
        ),

        GetPage(
          name: AppRoutes.home,
          page: () => const Scaffold(
            body: Center(
              child: Text('Home'),
            ),
          ),
        ),
      ],
    );
  }
}