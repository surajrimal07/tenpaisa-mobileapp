import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';

void animatednavigateTo(BuildContext context, Widget page) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: SharedAxisTransitionType.horizontal,
          fillColor: AppTheme.isDarkMode(context)
              ? AppColors.whitetextColor
              : AppColors.backgroundColor,
          child: child,
        );
      },
      transitionDuration: AppStrings.duration,
    ),
  );
}
