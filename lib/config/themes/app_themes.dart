import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';

final container = ProviderContainer();

final appThemeStateProvider = ChangeNotifierProvider((ref) => AppThemeState());

class AppThemeState extends ChangeNotifier {
  final userSharedPrefs = container.read(userSharedPrefsProvider);
  ThemeMode _themeMode = ThemeMode.light;

  AppThemeState() {
    _initThemeMode();
    _updateSystemUI();
  }

  ThemeMode get themeMode => _themeMode;

  Future<void> _initThemeMode() async {
    final savedThemeMode = await userSharedPrefs.getThemeMode();
    _themeMode = savedThemeMode;
    notifyListeners();
  }

  void setLightTheme() async {
    await userSharedPrefs.setThemeMode('light');
    _updateSystemUI();
    _themeMode = ThemeMode.light;
    notifyListeners();
  }

  void setDarkTheme() async {
    await userSharedPrefs.setThemeMode('dark');
    _updateSystemUI();
    _themeMode = ThemeMode.dark;
    notifyListeners();
  }

  void setSystemTheme() async {
    await userSharedPrefs.setThemeMode('system');
    _updateSystemUI();
    _themeMode = ThemeMode.system;
    notifyListeners();
  }

  void _updateSystemUI() {
    final ThemeData currentTheme =
        _themeMode == ThemeMode.dark ? AppTheme.darkTheme : AppTheme.lightTheme;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: currentTheme.primaryColor,
        statusBarBrightness:
            _themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,
        statusBarIconBrightness:
            _themeMode == ThemeMode.dark ? Brightness.light : Brightness.dark,

        //test code for navigation bar theming in dark mode

        // systemNavigationBarColor: _themeMode == ThemeMode.dark
        //     ? Colors.grey[900]
        //     : AppColors.primaryColor,

        //Colors.black
        // systemNavigationBarIconBrightness: _themeMode == ThemeMode.dark
        //     ? Brightness.light
        //     : Brightness.dark
      ),
    );
  }
}

class AppColors {
  static const Color btnColor = Color(0xFF9585C0);
  static const Color primaryColor = Color(0xFF6750A4);
  static const Color secondaryColor = Color(0xFF928D9C);
  static const Color tertiaryColor = Color(0xFF7D5260);
  static const Color errorColor = Color(0xFFCA6862);
  static const Color backgroundColor = Colors.white;
  static const Color outlineColor = Color(0xFFA29EA5);

  //for dark mode
  static const Color darkPrimaryColor = Color(0xFF6750A4);
  static const Color darkbackgroundColor = Color(0xFF000000);
  static const Color darktextColor = Colors.white;
  static const Color whitetextColor = Colors.black;
}

class MaterialColorGenerator {
  static MaterialColor from(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

class SystemUIConfig {
  static void configureSystemUI(Color statusBarColor) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: statusBarColor,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: statusBarColor,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
  }
}

class AppTheme {
  static Color getBorderColor(BuildContext context) {
    final theme = Theme.of(context);
    return theme.brightness == Brightness.dark ? Colors.white : Colors.black;
  }

  static bool isDarkMode(BuildContext context) {
    final theme = Theme.of(context);
    return theme.brightness == Brightness.dark;
  }

//
  static final lightTheme = ThemeData(
    primaryIconTheme: const IconThemeData(color: AppColors.primaryColor), //
    disabledColor: Colors.grey[400],
    indicatorColor: AppColors.primaryColor,
    dividerColor: AppColors.outlineColor,
    fontFamily: GoogleFonts.poppins().fontFamily,
    primarySwatch: MaterialColorGenerator.from(AppColors.primaryColor),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.light,

    inputDecorationTheme: InputDecorationTheme(
      iconColor: AppColors.primaryColor,
      hintStyle: const TextStyle(color: AppColors.primaryColor, fontSize: 12),
      errorStyle: const TextStyle(fontSize: 12),
      contentPadding: const EdgeInsets.fromLTRB(12, 16, 16, 16),
      //contentPadding: const EdgeInsets.symmetric(vertical: 14),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.primaryColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.darkPrimaryColor,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: AppColors.primaryColor,
      ),
    ),

    colorScheme: const ColorScheme.light(primary: AppColors.primaryColor),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily, color: Colors.black),
      bodyMedium: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily, color: Colors.black),
      // bodySmall: TextStyle(
      //     fontFamily: GoogleFonts.poppins().fontFamily, color: Colors.black),

      bodySmall: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontSize: 14,
          fontWeight: FontWeight.normal),
      titleLarge: TextStyle(
        fontFamily: GoogleFonts.poppins().fontFamily,
        color: Colors.black, //color: Colors.white,
      ),
    ),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      centerTitle: true,
      toolbarHeight: Sizes.dynamicHeight(6),
      backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,

      // titleTextStyle: TextStyle(
      //   color: Colors.white,
      //   fontSize: 30,
      // )
    ),
  );

  static final darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    dialogTheme: const DialogTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
      ),
      contentTextStyle: TextStyle(
        color: Colors.white,
      ),
    ),
    brightness: Brightness.dark,
    dividerColor: Colors.white,
    colorScheme: const ColorScheme.dark(primary: Colors.white),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.black,
      toolbarHeight: 40,
    ),
    canvasColor: Colors.black,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
    ),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: Color(0xFF333333),
      contentTextStyle: TextStyle(color: Colors.white),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF1F1F1F)),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
    inputDecorationTheme: InputDecorationTheme(
        contentPadding: const EdgeInsets.fromLTRB(12, 14, 14, 12),
        //contentPadding: const EdgeInsets.symmetric(vertical: 14),
        // filled: true,
        // fillColor: const Color(0xFF2B2B2B),
        hintStyle: const TextStyle(color: Colors.grey),
        errorStyle: const TextStyle(fontSize: 12),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        )

        // border: OutlineInputBorder(
        //   borderSide: BorderSide.none,
        //   borderRadius: BorderRadius.circular(8.0),
        // ),
        ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.grey[900],
      ),
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF1F1F1F),
      elevation: 2.0,
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily, color: Colors.white),
      bodyMedium: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily, color: Colors.white),
      titleLarge: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily, color: Colors.white),
      bodySmall: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily, color: Colors.grey),
    ),
  );
}

class AppIcons {
  static const String equityIcon = 'assets/logos/equity.jpg';
  static const String mutualIcon = 'assets/logos/mutual.png';
  static const String commoIcon = 'assets/logos/commo.png';
  static const String metalIcon = 'assets/logos/metal.png';
  static const String defaultdb = 'assets/images/content/default.png';
}
