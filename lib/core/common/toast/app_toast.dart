import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

enum Type { warn, error, success, info }

class CustomToast {
  static void showToast(
    String message, {
    Color? customBackgroundColor,
    Color? customTextColor,
    double? customFontSize,
    int? customTimeInSecForIosWeb,
    Toast? customToastLength,
    Type? customType,
  }) {
    Color backgroundColor = customBackgroundColor ??
        (customType == Type.warn
            ? Colors.orange
            : customType == Type.error
                ? Colors.red
                : customType == Type.success
                    ? Colors.green
                    : customType == Type.info
                        ? Colors.blue
                        : Colors.black);
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
