import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/feathures/home/presentation/view/dashboard_home.dart';

class CircleIndicator extends ConsumerWidget {
  const CircleIndicator({
    super.key,
    required this.pageIndex,
    required this.itemCount,
  });

  final int itemCount;
  final int pageIndex;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageControllers = ref.watch(currentPageNotifiersProvider);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
      child: CirclePageIndicator(
        dotColor: const Color.fromARGB(255, 187, 187, 187),
        selectedDotColor: AppTheme.isDarkMode(context)
            ? AppColors.darktextColor
            : AppColors.whitetextColor,
        itemCount: itemCount,
        currentPageNotifier: pageControllers[pageIndex],
        size: 4.0,
        selectedSize: 5.0,
      ),
    );
  }
}
