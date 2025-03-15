import 'package:ecommerce_crafty_bay/data/services/network_caller.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/screens/no_internet_screen.dart';
import 'package:ecommerce_crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final NetworkCaller _networkCaller = NetworkCaller();

  @override
  void initState() {
    super.initState();
    checkInternetAndMove();
  }

  Future<void> checkInternetAndMove() async {
    await Future.delayed(const Duration(seconds: 2));

    bool isConnected = await _networkCaller.isConnected();

    if (isConnected) {
      Get.offAll(const MainBottomNavScreen());
    } else {
      Get.offAll(const NoInternetScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            const AppLogo(),
            const Spacer(),
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text("Version 3.0.1"),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
