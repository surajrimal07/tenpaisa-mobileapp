import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';

class EmptyPortfolioWidget extends StatelessWidget {
  final String name;

  const EmptyPortfolioWidget({super.key, this.name = 'Portfolio'});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logos/empty.png',
          height: 100,
          width: 100,
        ),
        SizedBox(height: Sizes.dynamicHeight(1)),
        Text(
          '${PortfolioStrings.emptyPortoflio}$name',
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
