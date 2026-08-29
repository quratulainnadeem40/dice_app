import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/theme/theme_custom.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dice Roller',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.MAIN,
      getPages: AppPages.pages,
    );
  }
}