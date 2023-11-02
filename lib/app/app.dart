import 'package:flutter/material.dart';
import 'package:paisa/view/splash_view.dart';

import 'routes/approutes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    //print("we aare at app $isFirstTime");
    return MaterialApp(
      title: '10Paisa',
      debugShowCheckedModeBanner: false,
      home: const SplashView(),
      //initialRoute: isFirstTime ? AppRoute.onboardRoute : AppRoute.signinRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
