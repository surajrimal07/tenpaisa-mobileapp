import 'package:flutter/material.dart';

class MyColors {
  static const Color titleTextColor = Colors.black;
  static const Color subTextColor = Color.fromRGBO(0, 0, 0, 80);
  static const Color btnColor = Color.fromRGBO(27, 39, 112, 100);
  static const Color btnBorderColor = Color.fromARGB(255, 183, 181, 252);
  static const Color subTitleTextColor = Color(0xFF9593a8);
//
  static const Color primaryColor = Color.fromRGBO(27, 39, 112, 100);
  static const Color secondaryColor = Color(0xff1b1f28);
}

// class HexColor extends Color {
//   static int _getColorFromHex(String hexColor) {
//     hexColor = hexColor.toUpperCase().replaceAll("#", "");
//     if (hexColor.length == 6) {
//       hexColor = "FF$hexColor";
//     }
//     return int.parse(hexColor, radix: 16);
//   }

//   HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
// }
