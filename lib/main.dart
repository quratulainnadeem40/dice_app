import 'package:dice_app/core/routes/page_routes.dart';
import 'package:dice_app/feature/history/controller/history_controller.dart';
import 'package:dice_app/feature/setting/controller/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();

  // Initialize global permanent core controllers
  Get.put<SettingsController>(SettingsController(), permanent: true);
  Get.put<HistoryController>(HistoryController(), permanent: true);

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