import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_text_styles.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/home/presentation/view/dashboard_home.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/home/presentation/widget/circle_indicator.dart';
import 'package:paisa/feathures/home/presentation/widget/dashboard_list.dart';

class CommoditiesContainer extends ConsumerStatefulWidget {
  const CommoditiesContainer({super.key});

  @override
  CommoditiesContainerState createState() => CommoditiesContainerState();
}

class CommoditiesContainerState extends ConsumerState<CommoditiesContainer> {
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
                Text.rich(
                  TextSpan(
                    text: currentPageNotifiers[2].value == 0
                        ? 'Commodities'
                        : 'Metals',
                    style: AppTextStyles.titleTextStyle,
                    children: state.isLoading
                        ? []
                        : [
                            TextSpan(
                              text:
                                  '(${PortfolioStrings.asOf}${state.index[0].date.toString()})',
                              style: GoogleFonts.poppins(
                                fontSize: 8,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: Sizes.dynamicHeight(37.5),
            child: PageView(
              controller: pageControllers[2],
              onPageChanged: (int index) {
                setState(() {
                  ref.read(currentPageNotifiersProvider)[2].value = index;
                });
              },
              children: const [
                DashboardList(listName: "Commodity", nameLength: 25),
                DashboardList(listName: "Metals", nameLength: 25),
              ],
            ),
          ),
          const CircleIndicator(itemCount: 2, pageIndex: 2),
        ],
      ),
    );
  }
}
