import 'package:flutter/material.dart';

class ResponsiveSizes {
  static double _screenWidth = 0.0;
  static double _screenHeight = 0.0;

  static void init(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _screenHeight = MediaQuery.of(context).size.height;
  }

  static double responsiveWidth(double percentage) {
    return _screenWidth * (percentage / 100);
  }

  static double responsiveHeight(double percentage) {
    return _screenHeight * (percentage / 100);
  }
}

class Sizes {
  static double p4Width = ResponsiveSizes.responsiveWidth(4);
  static double p8Width = ResponsiveSizes.responsiveWidth(8);
  static double p16Width = ResponsiveSizes.responsiveWidth(16);
  static double p20Width = ResponsiveSizes.responsiveWidth(20);
  static double p24Width = ResponsiveSizes.responsiveWidth(24);
  static double p32Width = ResponsiveSizes.responsiveWidth(32);
  static double p48Width = ResponsiveSizes.responsiveWidth(48);
  static double p64Width = ResponsiveSizes.responsiveWidth(64);
  static double dynamicWidth(double percentage) =>
      ResponsiveSizes.responsiveWidth(percentage);

  static double p4Height = ResponsiveSizes.responsiveHeight(4);
  static double p8Height = ResponsiveSizes.responsiveHeight(8);
  static double p16Height = ResponsiveSizes.responsiveHeight(16);
  static double p20Height = ResponsiveSizes.responsiveHeight(20);
  static double p24Height = ResponsiveSizes.responsiveHeight(24);
  static double p32Height = ResponsiveSizes.responsiveHeight(32);
  static double p48Height = ResponsiveSizes.responsiveHeight(48);
  static double p64Height = ResponsiveSizes.responsiveHeight(64);
  static double dynamicHeight(double percentage) =>
      ResponsiveSizes.responsiveHeight(percentage);
}
