import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';

class EmptyAssetsWidget extends StatelessWidget {
  const EmptyAssetsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          PortfolioStrings.emptyPortfolioUrl,
          height: Sizes.dynamicHeight(15),
          width: Sizes.dynamicWidth(30),
        ),
        SizedBox(height: Sizes.dynamicHeight(1.3)),
        Text(
          PortfolioStrings.noStocks,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
