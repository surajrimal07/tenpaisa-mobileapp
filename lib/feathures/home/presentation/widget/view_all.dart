import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/themes/app_themes.dart';

class BuildViewAll extends StatelessWidget {
  const BuildViewAll({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'View All',
      style: GoogleFonts.poppins(
        color: AppTheme.isDarkMode(context)
            ? AppColors.darktextColor
            : AppColors.primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
