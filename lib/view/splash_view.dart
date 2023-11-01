import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paisa/app/routes/approutes.dart';

class SplashView extends StatefulWidget {
  final bool isFirstTime;
  const SplashView({super.key, required this.isFirstTime});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacementNamed(context, AppRoute.signinRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/logos/logo.png'),
      ),
    );
  }
}
