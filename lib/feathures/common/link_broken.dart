import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/splash/presentation/widget/loading_widget.dart';

class BrokenLink extends ConsumerWidget {
  const BrokenLink({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: Sizes.dynamicHeight(40),
            child: AnimatedLoading(
              path: NotFound.animationPath,
              width: Sizes.dynamicWidth(100),
              height: Sizes.dynamicHeight(100),
            ),
          ),
          Positioned(
            bottom: 230,
            left: 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: const Text(
                ErrorStrings.notFound,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 130,
            left: 30,
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 60,
              child: const Text(
                ErrorStrings.subTitle,
                style: TextStyle(
                  color: Colors.black38,
                  fontSize: 16,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            left: 40,
            right: 40,
            child: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 40,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.primaryColor,
                ),
                child: Center(
                  child: Text(
                    ErrorStrings.errorButton.toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
