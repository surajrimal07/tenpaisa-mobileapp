import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/splash/presentation/viewmodel/splash_view_model.dart';
import 'package:paisa/feathures/splash/presentation/widget/loading_widget.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstTime = ref.read(isFirstTimeProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFirstTime.checkFirstTime(ref);
    });

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primaryColor, AppColors.primaryColor],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: Sizes.dynamicWidth(70),
                  height: Sizes.dynamicHeight(40),
                  child: Image.asset(SplashStrings.splashImage),
                ),
              ),
              SizedBox(height: Sizes.dynamicHeight(20)),
              AnimatedLoading(
                  path: SplashStrings.splashAnimationPath,
                  width: Sizes.dynamicWidth(30),
                  height: Sizes.dynamicHeight(10)),
              const Text(
                AppStrings.appDeveloper,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              const Text(
                AppStrings.appVersion,
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
