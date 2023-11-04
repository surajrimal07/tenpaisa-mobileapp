import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomToast {
  static void showToast(
    String message, {
    Color? customBackgroundColor,
    Color? customTextColor,
    double? customFontSize,
    int? customTimeInSecForIosWeb,
    Toast? customToastLength,
  }) {
    Color backgroundColor = customBackgroundColor ?? Colors.black;
    Color textColor = customTextColor ?? Colors.white;
    double fontSize = customFontSize ?? 14.0;
    int timeInSecForIosWeb = customTimeInSecForIosWeb ?? 1;
    Toast toastLength = customToastLength ?? Toast.LENGTH_SHORT;

    Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize,
    );
  }
}
