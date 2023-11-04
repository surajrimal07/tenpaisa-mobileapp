import 'package:flutter/material.dart';

class CustomSnackbar {
  static void showSnackbar(
    BuildContext context,
    String message, {
    Color? customBackgroundColor,
    Color? customTextColor,
    double? customFontSize,
    Duration? customDuration,
  }) {
    final snackbar = SnackBar(
      content: Text(
        message,
        style: TextStyle(
          color: customTextColor ?? Colors.white,
          fontSize: customFontSize ?? 14.0,
        ),
      ),
      backgroundColor: customBackgroundColor ?? Colors.black,
      duration: customDuration ?? const Duration(seconds: 3),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
