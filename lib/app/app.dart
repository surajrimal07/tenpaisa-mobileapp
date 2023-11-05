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
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            Brightness.light, // Change this according to your needs
        //systemNavigationBarColor: Colors.transparent,
        systemNavigationBarColor: MyColors.btnColor,
        systemNavigationBarIconBrightness:
            Brightness.light, // Change this according to your needs
      ),
    );

    return MaterialApp(
      title: '10Paisa',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primaryColor: MyColors.btnColor, // Set your preferred primary color
        // appBarTheme: const AppBarTheme(
        //     // textTheme: TextTheme(
        //     //   // headline6: TextStyle(
        //     //   //   color: Colors.white, // Set the app bar title text color
        //     //   // ),
        //     // ),
        //     ),
      ),

      home: const SplashView(),
      //initialRoute: isFirstTime ? AppRoute.onboardRoute : AppRoute.signinRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
