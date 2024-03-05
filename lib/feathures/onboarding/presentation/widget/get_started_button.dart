import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/approutes.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/shared_prefs/user_shared_prefs.dart';
import 'package:paisa/core/utils/string_utils.dart';

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

  loadingHandler(NavigationService navigationService,
      UserSharedPrefs userSharedPrefs) async {
    setState(() {
      isLoading = true;
    });

    await userSharedPrefs.setOnBoarded();
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isLoading = false;
    });

    navigationService.routeToAndReplace(AppRoute.authRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        var navigationService = ref.read(navigationServiceProvider);
        return GestureDetector(
          onTap: () => loadingHandler(
              navigationService, ref.read(userSharedPrefsProvider)),
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            width: Sizes.dynamicHeight(38),
            height: Sizes.dynamicHeight(6),
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(15),
            ),
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
                      OnBoarding.getStarted,
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
            ),
          ),
        );
      },
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
      width: Sizes.dynamicHeight(38),
      height: Sizes.dynamicHeight(6),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        borderRadius: BorderRadius.circular(15.0),
        onTap: onTap,
        splashColor: AppColors.primaryColor,
        child: const Center(
          child: Text(OnBoarding.skip,
              style: TextStyle(
                fontSize: 24,
                color: AppColors.primaryColor,
                fontFamily: 'Poppins',
              )),
        ),
      ),
    );
  }
}
