import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final double size;
  final Color color;
  final bool showText;
  final String text;
  final double fontSize;

  const LoadingIndicatorWidget({
    super.key,
    this.size = 40,
    this.color = AppColors.primaryColor,
    required this.showText,
    this.text = '',
    this.fontSize = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpinKitDoubleBounce(
          color: color,
          size: size,
        ),
        Visibility(
          visible: showText,
          child: Column(
            children: [
              SizedBox(height: Sizes.dynamicHeight(1)),
              Text(
                text,
                style: GoogleFonts.poppins(
                    fontSize: 14, fontWeight: FontWeight.w400, color: color),
              ),
            ],
          ),
        ),
      ],
    );
  }
}



        // const CircularProgressIndicator(
        //   valueColor: AlwaysStoppedAnimation<Color>(
        //     AppColors.primaryColor,
        //   ),
        // ),