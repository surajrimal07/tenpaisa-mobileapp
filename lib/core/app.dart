import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/approutes.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/router/routegenerator_routes.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  AppState createState() => AppState();
}

class AppState extends ConsumerState<App> {
  late NavigationService navigationService;
  late GlobalKey<NavigatorState> navKey;

  @override
  void initState() {
    super.initState();
    navigationService = ref.read(navigationServiceProvider);
    navKey = navigationService.navigatorKey;

    //for web socket
    //ref.read(webSocketServiceProvider);

    //themeMode = ref.watch(appThemeStateProvider);
    // themeService = ref.read(themeServiceProvider);
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveSizes.init(context);
    var themeMode = ref.watch(appThemeStateProvider).themeMode;
    //ref.watch(connectivityStatusProvider);
    //final sharedPrefs = ref.read(userSharedPrefsProvider);
    //final themeMode = ref.watch(themeStateProvider);

    return MaterialApp(
      navigatorKey: navKey,
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      initialRoute: AppRoute.splashRoute,
      routes: AppRoute.getApplicationRoute(),
      onGenerateRoute: (settings) {
        return RouteGenerator.generateRoutes(settings, navigationService);
      },
    );
  }
}
