import 'package:flutter/material.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';

class CommonAuthHeader extends StatelessWidget {
  const CommonAuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.dynamicHeight(38),
      width: Sizes.dynamicWidth(100),
      child: Image.asset(
        LoginStrings.loginImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
