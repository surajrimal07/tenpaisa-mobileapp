// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_text_styles.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/home/presentation/view/home_view.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/home/presentation/widget/text_widget.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_portfolio.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PortfolioContainer extends ConsumerWidget {
  const PortfolioContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portfolioViewModelProvider);
    final index = ref.watch(indexViewModelProvider);
    final portfolios =
        ref.watch(portfolioViewModelProvider.notifier).state.portfoliosEntity;

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.getBorderColor(context), width: 0.2),
      ),
      padding: const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 8),
      child: Column(
        children: [
          SizedBox(
            height: Sizes.dynamicHeight(3.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text.rich(
                  TextSpan(
                    text: PortfolioStrings.myPortoflios,
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    children: state.isLoading
                        ? []
                        : [
                            TextSpan(
                              text:
                                  '(${PortfolioStrings.asOf}${index.index[0].date.toString()})',
                              style: GoogleFonts.poppins(
                                  fontSize: 8, fontWeight: FontWeight.normal),
                            ),
                          ],
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    ref.read(selectedIndexProvider.notifier).state = 2;
                  },
                  child: Text(
                    PortfolioStrings.viewAll,
                    style: GoogleFonts.poppins(
                      color: AppTheme.isDarkMode(context)
                          ? AppColors.darktextColor
                          : AppColors.whitetextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Skeletonizer(
              enabled: state.isLoading,
              child: portfolios.isEmpty
                  ? const EmptyPortfolioWidget()
                  : SizedBox(
                      height: Sizes.dynamicHeight(22.6),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemExtent: 160,
                        itemCount: portfolios.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          final portfolio = portfolios[index];

                          return InkWell(
                            onTap: () {
                              ref.read(navigationServiceProvider).routeTo(
                                '/portfolioDetailView',
                                arguments: {
                                  'portfolioIndex': ref
                                      .watch(portfolioViewModelProvider)
                                      .portfoliosEntity
                                      .indexOf(portfolio),
                                },
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.only(right: 10),
                              decoration: BoxDecoration(
                                color: AppTheme.isDarkMode(context)
                                    ? AppColors.darktextColor.withOpacity(0.12)
                                    : AppColors.primaryColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: portfolio.stocks!.isNotEmpty
                                  ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(portfolio.name,
                                            maxLines: 1,
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            )),
                                        SizedBox(
                                            height: Sizes.dynamicHeight(1.3)),
                                        Text(
                                          '${PortfolioStrings.valueText} ${portfolio.portfoliovalue}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                            height: Sizes.dynamicHeight(1.1)),
                                        Text(
                                          '${PortfolioStrings.costText} ${portfolio.portfoliocost}',
                                          style: GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                            height: Sizes.dynamicHeight(1.1)),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: PortfolioStrings
                                                    .returnsText,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: AppTheme.isDarkMode(
                                                            context)
                                                        ? AppColors
                                                            .darktextColor
                                                        : AppColors
                                                            .whitetextColor,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              buildTextSpan(
                                                  text:
                                                      'Rs ${portfolio.gainLossRecords![0].portgainloss.toStringAsFixed(0)}',
                                                  fontSize: 12,
                                                  value: portfolio
                                                      .gainLossRecords![0]
                                                      .portgainloss),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                            height: Sizes.dynamicHeight(1.1)),
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: PortfolioStrings.pnl,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 12,
                                                    color: AppTheme.isDarkMode(
                                                            context)
                                                        ? AppColors
                                                            .darktextColor
                                                        : AppColors
                                                            .whitetextColor,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                              buildTextSpan(
                                                  text:
                                                      '${portfolio.percentage!}% ${portfolio.percentage! < 0 ? 'Loss' : 'Profit'}',
                                                  fontSize: 12,
                                                  value: portfolio.percentage!),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(portfolio.name,
                                            maxLines: 1,
                                            style: AppTextStyles.itemtext1),
                                        Image.asset(
                                          PortfolioStrings.emptyPortfolioUrl,
                                          height: Sizes.dynamicHeight(12),
                                          width: Sizes.dynamicWidth(30),
                                        ),
                                        SizedBox(
                                            height: Sizes.dynamicHeight(1)),
                                        Text(PortfolioStrings.noStocks,
                                            style: AppTextStyles.text14w400),
                                      ],
                                    ),
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
