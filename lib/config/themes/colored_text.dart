import 'package:flutter/material.dart';
import 'package:paisa/config/themes/app_themes.dart';

class BuildColoredText {
  final String text;
  final num value;
  final TextStyle textStyle;

  BuildColoredText({
    required this.text,
    required this.value,
    this.textStyle =
        const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
  });

  Color _getTextColor() {
    return value < 0 ? AppColors.redColor : AppColors.greenColor;
  }

  TextStyle _getTextStyle() {
    Color textColor = _getTextColor();
    return textStyle.copyWith(color: textColor);
  }

  Widget build() {
    return Text(
      text,
      style: _getTextStyle(),
    );
  }
}
