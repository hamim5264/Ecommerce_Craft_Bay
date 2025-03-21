import 'package:ecommerce_crafty_bay/controller_binder.dart';
import 'package:ecommerce_crafty_bay/presentation/state_holders/theme_controller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/auth/splash_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/utility/app_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: AppThemeData.lightThemeData,
      darkTheme: AppThemeData.darkThemeData,
      themeMode: ThemeController().themeMode.value,
      home: const SplashScreen(),
      initialBinding: ControllerBinder(),
    );
  }
}
