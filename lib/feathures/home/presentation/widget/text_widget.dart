import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/themes/app_themes.dart';

TextSpan buildTextSpan(
    {required String text, required double fontSize, required num value}) {
  return TextSpan(
    text: text,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      color: value > 0
          ? AppColors.greenColor
          : value < 0
              ? AppColors.redColor
              : AppColors.whitetextColor,
      fontWeight: FontWeight.w400,
    ),
  );
}
