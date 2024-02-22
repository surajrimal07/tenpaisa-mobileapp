import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/home/presentation/view/dashboard_home.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/home/presentation/widget/dashboard_list.dart';

class TurnoverContainer extends ConsumerStatefulWidget {
  const TurnoverContainer({super.key});

  @override
  TurnoverContainerState createState() => TurnoverContainerState();
}

class TurnoverContainerState extends ConsumerState<TurnoverContainer> {
  @override
  Widget build(BuildContext context) {
    final pageControllers = ref.watch(pageControllersProvider);
    final currentPageNotifiers = ref.watch(currentPageNotifiersProvider);
    final index = ref.watch(indexViewModelProvider);

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
            height: Sizes.dynamicHeight(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: currentPageNotifiers[1].value == 0
                        ? 'Top Turnovers'
                        : (currentPageNotifiers[1].value == 1)
                            ? 'Top Volumes'
                            : 'Top Transacts',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    children: [
                      TextSpan(
                        text: index.isLoading
                            ? ''
                            : '(${PortfolioStrings.asOf}${index.index[0].date.toString()})',
                        style: GoogleFonts.poppins(
                          fontSize: 8,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    ref.read(navigationServiceProvider).routeTo(
                      '/category',
                      arguments: {
                        'initialTabIndex': currentPageNotifiers[1].value + 2,
                        'ref': ref,
                      },
                    );
                  },
                  child: Text(
                    'View All',
                    style: GoogleFonts.poppins(
                      color: AppTheme.isDarkMode(context)
                          ? AppColors.darktextColor
                          : AppColors.primaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Sizes.dynamicHeight(37.5),
            child: PageView(
              controller: pageControllers[1],
              onPageChanged: (int index) {
                setState(() {
                  ref.read(currentPageNotifiersProvider)[1].value = index;
                });
              },
              children: [
                for (var listName in [
                  "Top Turnover",
                  "Top Volume",
                  "Top Transaction"
                ])
                  DashboardList(
                    listName: listName,
                    nameLength: 25,
                    limit: true,
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 0, 0),
            child: CirclePageIndicator(
              dotColor: const Color.fromARGB(255, 187, 187, 187),
              selectedDotColor: AppColors.whitetextColor,
              itemCount: 3,
              currentPageNotifier: currentPageNotifiers[1],
              size: 4.0,
              selectedSize: 5.0,
            ),
          ),
        ],
      ),
    );
  }
}
