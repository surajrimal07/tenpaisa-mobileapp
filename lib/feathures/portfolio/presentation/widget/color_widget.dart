import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/themes/app_themes.dart';

final colorProvider = Provider<Color Function(BuildContext, num)>((ref) {
  return (context, value) {
    final isDarkMode = AppTheme.isDarkMode(context);

    Color cardColor;
    if (isDarkMode) {
      cardColor = value >= 0
          ? const Color.fromARGB(255, 61, 86, 80)
          : const Color.fromARGB(255, 106, 75, 71);
    } else {
      cardColor = value >= 0
          ? const Color.fromARGB(255, 184, 218, 147)
          : const Color.fromARGB(255, 220, 147, 143);
    }

    return cardColor;
  };
});
