import 'package:flutter/material.dart';

import 'routes/approutes.dart';

class App extends StatelessWidget {
  final bool isFirstTime;

  const App({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10Paisa',
      debugShowCheckedModeBanner: false,
      initialRoute: isFirstTime ? AppRoute.onboardRoute : AppRoute.signinRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
