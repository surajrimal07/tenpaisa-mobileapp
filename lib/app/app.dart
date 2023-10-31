import 'package:flutter/material.dart';

import 'routes/approutes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '10Paisa',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.onboardRoute,
      routes: AppRoute.getApplicationRoute(),
    );
  }
}
