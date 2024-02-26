//ref.watch(onboardingStateProvider.notifier).state = newIndex;

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/onboarding/presentation/view/onboarding_view.dart';
import 'package:paisa/feathures/onboarding/presentation/widget/get_started_button.dart';
import 'package:paisa/feathures/splash/presentation/widget/loading_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingWidget extends ConsumerWidget {
  const OnboardingWidget({super.key});

  Widget animationDo(int index, int delay, Widget child) {
    if (index == 1) {
      return FadeOutRight(
        delay: Duration(milliseconds: delay),
        child: child,
      );
    }
    return FadeOutRight(
      delay: Duration(milliseconds: delay),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    final pageController = ref.watch(pageControllerProvider);
    ref.watch(onboardingStateProvider);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: PageView.builder(
              controller: pageController,
              itemCount: listOfItems.length,
              onPageChanged: (newIndex) {
                ref.read(onboardingStateProvider.notifier).state = newIndex;
              },
              physics: const BouncingScrollPhysics(),
              itemBuilder: ((context, index) {
                return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(15, 40, 15, 10),
                        width: Sizes.dynamicWidth(90),
                        height: Sizes.dynamicHeight(40),
                        child: animationDo(
                          index,
                          100,
                          AnimatedLoading(
                              path: listOfItems[index].animation,
                              width: Sizes.dynamicWidth(30),
                              height: Sizes.dynamicHeight(10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25, bottom: 15),
                        child: animationDo(
                          index,
                          300,
                          Text(
                            listOfItems[index].title,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                      animationDo(
                        index,
                        500,
                        Text(
                          listOfItems[index].subTitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.primaryColor,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmoothPageIndicator(
                  controller: pageController,
                  count: listOfItems.length,
                  effect: const ExpandingDotsEffect(
                    spacing: 6.0,
                    radius: 4.0,
                    dotWidth: 4.0,
                    dotHeight: 4.0,
                    expansionFactor: 3.8,
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.primaryColor,
                  ),
                  onDotClicked: (newIndex) {
                    pageController.animateToPage(
                      newIndex,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  },
                ),
                ref.read(onboardingStateProvider) == 2
                    ? GetStartBtn(size: size, textTheme: textTheme)
                    : SkipBtn(
                        size: size,
                        textTheme: textTheme,
                        onTap: () {
                          pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 1000),
                            curve: Curves.fastOutSlowIn,
                          );
                        },
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
