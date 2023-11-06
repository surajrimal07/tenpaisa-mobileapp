import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paisa/utils/colors_utils.dart';
import 'package:paisa/view/splash_view.dart';

import 'routes/approutes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MyColors.btnColor, //Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: MyColors.btnColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: '10Paisa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColors.btnColor,
      ),

      home: const SplashView(),
      //initialRoute: isFirstTime ? AppRoute.onboardRoute : AppRoute.signinRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
