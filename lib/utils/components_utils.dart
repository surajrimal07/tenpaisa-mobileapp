import 'package:flutter/material.dart';
import 'package:paisa/app/routes/approutes.dart';

import 'colors_utils.dart';

class GetStartBtn extends StatefulWidget {
  const GetStartBtn({
    super.key,
    required this.size,
    required this.textTheme,
  });

  final Size size;
  final TextTheme textTheme;

  @override
  State<GetStartBtn> createState() => _GetStartBtnState();
}

class _GetStartBtnState extends State<GetStartBtn> {
  bool isLoading = false;

  loadingHandler() {
    setState(() {
      isLoading = true;
      Future.delayed(const Duration(seconds: 2)).then((value) {
        isLoading = false;
        Navigator.pushReplacementNamed(context, AppRoute.signinRoute);
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: loadingHandler,
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: widget.size.width / 1.5,
        height: widget.size.height / 13,
        decoration: BoxDecoration(
            color: MyColors.btnColor, borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: isLoading
              ? const Center(
                  child: SizedBox(
                    width: 30,
                    height: 30,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                )
              : const Text(
                  "Get Started now",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
        ),
      ),
    );
  }
}

class SkipBtn extends StatelessWidget {
  const SkipBtn({
    super.key,
    required this.size,
    required this.textTheme,
    required this.onTap,
  });

  final Size size;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      width: size.width / 1.5,
      height: size.height / 13,
      decoration: BoxDecoration(
          border: Border.all(
            color: MyColors.btnBorderColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onTap,
        splashColor: MyColors.btnBorderColor,
        child: const Center(
          child: Text("Skip",
              style: TextStyle(
                fontSize: 14,
                color: MyColors.subTextColor,
                fontFamily: 'Poppins',
                //fontWeight: FontWeight.bold,
              )),
        ),
      ),
    );
  }
}
