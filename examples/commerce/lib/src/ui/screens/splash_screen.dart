import 'package:commerce/src/utils/app_assets.dart';
import 'package:flutter/material.dart';
import "package:auto_route/auto_route.dart";

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // context.router.replace(route)
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          AppAssets.logo,
          height: 245,
          width: 245,
        ),
      ),
    );
  }
}
