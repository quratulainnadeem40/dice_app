import 'package:dice_app/core/routes/app_routes.dart';
import 'package:dice_app/core/routes/page_routes.dart';
import 'package:dice_app/feature/history/controller/history_controller.dart';
import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // App-level global controllers (Permanent)
  Get.put(SettingsController(), permanent: true);
  Get.put(HistoryController(), permanent: true);

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