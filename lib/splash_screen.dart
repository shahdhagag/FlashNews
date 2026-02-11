
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:newsApp/core/utiles/app_assets.dart';
import 'package:newsApp/core/utiles/extentions.dart';

import 'core/utiles/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      context.go(AppRouts.homeScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Image.asset(
                AppAssets.appLogoLight,
                width: context.w(300),
              ),
            ),
          ),
        ],
      ),
    );
  }
}