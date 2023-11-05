import 'dart:async';

import 'package:flutter/material.dart';
import 'package:paisa/app/routes/approutes.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkFirstTime();
  }

  void checkFirstTime() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    //String? userToken = prefs.getString('userToken');
    dynamic userToken = prefs.get('userToken');

    if (isFirstTime) {
      await prefs.setBool('isFirstTime', false);
    }

    Timer(const Duration(seconds: 1), () {
      if (isFirstTime == true) {
        //print("We are here 118, first time app opening, opening onboarding");
        Navigator.pushReplacementNamed(context, AppRoute.onboardRoute);
        //print("not working");
      } else if (userToken != null) {
        //print(userToken);
        print("User token is true ");
        Navigator.pushReplacementNamed(context, AppRoute.dashboardRoute);
        //print("not working");
      } else {
        //print(userToken);
        //print("We are here 46");
        print("user token is false");
        Navigator.pushReplacementNamed(context, AppRoute.signinRoute);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              MyColors.btnColor,
              MyColors.btnColor
            ], // Set your desired gradient colors
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 250,
            height: 250,
            child: Image.asset('assets/logos/logo.png'),
          ),
        ),
      ),
    );
  }
}
