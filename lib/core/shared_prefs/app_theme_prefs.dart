// import 'package:dartz/dartz.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../failure/failure.dart';

// final themeSharedPrefsProvider = Provider<AppThemePrefs>((ref) {
//   return AppThemePrefs();
// });

// class AppThemePrefs {
//   late SharedPreferences _sharedPreferences;

//   Future<Either<Failure, bool>> setTheme(bool value) async {
//     try {
//       _sharedPreferences = await SharedPreferences.getInstance();
//       _sharedPreferences.setBool('isDarkTheme', value);
//       return const Right(true);
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }

//   Future<Either<Failure, bool>> getTheme() async {
//     try {
//       _sharedPreferences = await SharedPreferences.getInstance();

//       final isDark = _sharedPreferences.getBool('isDarkTheme') ?? false;
//       return Right(isDark);
//     } catch (e) {
//       return Left(Failure(error: e.toString()));
//     }
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class AppSharedPrefs {
//   static AppSharedPrefs? _instance;
//   static SharedPreferences? _prefs;

//   factory AppSharedPrefs() {
//     if (_instance == null) {
//       throw Exception('AppSharedPrefs is not initialized. '
//           'Please call AppSharedPrefs.ensureInitialized before.');
//     }
//     return _instance!;
//   }

//   const AppSharedPrefs._();

//   static ensureInitialized() async {
//     _prefs ??= await SharedPreferences.getInstance();
//     _instance ??= const AppSharedPrefs._();
//   }

//   static const _themeKey = 'theme';

//   ThemeMode themeMode() {
//     final themeValue = _prefs!.getInt(_themeKey);
//     if (themeValue == null) return ThemeMode.system;

//     return ThemeMode.values[themeValue];
//   }

//   Future<void> updateThemeMode(ThemeMode theme) async {
//     await _prefs!.setInt(_themeKey, theme.index);
//   }
// }
