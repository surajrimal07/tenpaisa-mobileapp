// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/presentation/widget/commodity_widget.dart';
import 'package:paisa/feathures/home/presentation/widget/dashboard_header_widget.dart';
import 'package:paisa/feathures/home/presentation/widget/exit_dialog.dart';
import 'package:paisa/feathures/home/presentation/widget/handle_refresh.dart';
import 'package:paisa/feathures/home/presentation/widget/portfolio_card_widget.dart';
import 'package:paisa/feathures/home/presentation/widget/summary_widget.dart';
import 'package:paisa/feathures/home/presentation/widget/trending_widget.dart';
import 'package:paisa/feathures/home/presentation/widget/turnover_widget.dart';
import 'package:paisa/feathures/home/presentation/widget/user_header_widget.dart';
import 'package:paisa/feathures/home/presentation/widget/worldmarket_widget.dart';

final pageControllersProvider = Provider<List<PageController>>((ref) {
  return [
    PageController(),
    PageController(),
    PageController(),
    PageController(),
  ];
});

final scrollControllerProvider = Provider<ScrollController>((ref) {
  return ScrollController();
});

final currentPageNotifiersProvider = Provider<List<ValueNotifier<int>>>((ref) {
  return [
    ValueNotifier<int>(0),
    ValueNotifier<int>(0),
    ValueNotifier<int>(0),
    ValueNotifier<int>(0),
  ];
});

class DashboardView extends ConsumerWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = ref.watch(scrollControllerProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        if (didPop) {
          return;
        }
        //found new solution
        //https://github.com/flutter/flutter/issues/138614
        //https://docs.flutter.dev/release/breaking-changes/android-predictive-back#migrating-a-back-confirmation-dialog
        final bool shouldClose = await showExitDialog(context);
        if (shouldClose) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(toolbarHeight: 0),
        body: RefreshIndicator(
          onRefresh: () => handleAllRefresh(ref),
          child: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              controller: scrollController,
              child: const Column(
                children: [
                  Header(),
                  PortfolioCard(),
                  PortfolioContainer(),
                  TrendingContainer(),
                  TurnoverContainer(),
                  WorldMarketContainer(),
                  CommoditiesContainer(),
                  MySummaryContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
