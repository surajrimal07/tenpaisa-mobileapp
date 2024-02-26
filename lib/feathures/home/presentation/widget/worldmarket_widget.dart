import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_text_styles.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/home/presentation/view/dashboard_home.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/home/presentation/widget/circle_indicator.dart';
import 'package:paisa/feathures/home/presentation/widget/view_all.dart';
import 'package:paisa/feathures/home/presentation/widget/worldmarket_list.dart';

class WorldMarketContainer extends ConsumerStatefulWidget {
  const WorldMarketContainer({super.key});

  @override
  WorldMarketContainerState createState() => WorldMarketContainerState();
}

class WorldMarketContainerState extends ConsumerState<WorldMarketContainer> {
  @override
  Widget build(BuildContext context) {
    final pageControllers = ref.watch(pageControllersProvider);
    final currentPageNotifiers = ref.watch(currentPageNotifiersProvider);
    final state = ref.watch(indexViewModelProvider);

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.getBorderColor(context),
          width: 0.2,
        ),
      ),
      padding: const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 8),
      child: Column(
        children: [
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(TextSpan(
                  text: (() {
                    switch (currentPageNotifiers[3].value) {
                      case 0:
                        return 'Us Market';
                      case 1:
                        return 'Europe Market';
                      case 2:
                        return 'Asian Market';
                      case 3:
                        return 'Forex Market';
                      default:
                        return 'Crypto Market';
                    }
                  })(),
                  style: AppTextStyles.titleTextStyle,
                  children: state.isLoading
                      ? []
                      : [
                          TextSpan(
                            text:
                                '(${PortfolioStrings.asOf}${state.index[0].date.toString()})',
                            style: AppTextStyles.subTextStyle,
                          ),
                        ],
                )),
                MaterialButton(
                  onPressed: () {
                    ref.read(navigationServiceProvider).routeTo(
                      '/worldmarket',
                      arguments: {
                        'initialTabIndex': currentPageNotifiers[3].value,
                        'ref': ref,
                      },
                    );
                  },
                  child: const BuildViewAll(),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Sizes.dynamicHeight(37.5),
            child: PageView(
              controller: pageControllers[3],
              onPageChanged: (int index) {
                setState(() {
                  ref.read(currentPageNotifiersProvider)[3].value = index;
                });
              },
              children: [
                for (var marketName in [
                  "American Market",
                  "Europe Market",
                  "Asian Market",
                  "Forex Market",
                  "Crypto Market"
                ])
                  WorldMarketList(listName: marketName, limit: true),
              ],
            ),
          ),
          const CircleIndicator(itemCount: 5, pageIndex: 3),
        ],
      ),
    );
  }
}
