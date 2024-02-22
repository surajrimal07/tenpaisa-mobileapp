// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_text_styles.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/config/themes/colored_text.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_stocks.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

class MySummaryContainer extends ConsumerWidget {
  const MySummaryContainer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portfolioViewModelProvider);
    final watchlist = ref.watch(watchlistViewModelProvider);
    final index = ref.watch(indexViewModelProvider);
    final auth = ref.watch(authEntityProvider);
    final portfolios =
        ref.watch(portfolioViewModelProvider.notifier).state.portfoliosEntity;

    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppTheme.getBorderColor(context),
          width: 0.2,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 7, right: 7, top: 4, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text.rich(
              TextSpan(
                text: 'Market Summary',
                style: AppTextStyles.titleTextStyle,
                children: state.isLoading
                    ? []
                    : [
                        TextSpan(
                          text:
                              '(${PortfolioStrings.asOf}${index.index[0].date.toString()})',
                          style: AppTextStyles.subTextStyle,
                        ),
                      ],
              ),
            ),
            SizedBox(height: Sizes.dynamicHeight(1.2)),
            state.isLoading
                ? SizedBox(
                    height: Sizes.dynamicHeight(30),
                    child: const Center(
                        child: LoadingIndicatorWidget(
                      size: 40,
                      showText: false,
                      text: PortfolioStrings.loadingPortfolios,
                    )))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Nepse Index Today',
                            style: AppTextStyles.boldTextStyle,
                          ),
                          BuildColoredText(
                            text: index.index[0].index.toString(),
                            value: index.index[0].percentageChange,
                            textStyle: AppTextStyles.normalTextStyle,
                          ).build(),
                        ],
                      ),
                      SizedBox(height: Sizes.dynamicHeight(1.2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Percentage Change',
                            style: AppTextStyles.boldTextStyle,
                          ),
                          BuildColoredText(
                            text: index.index[0].percentageChange.toString(),
                            value: index.index[0].percentageChange,
                            textStyle: AppTextStyles.normalTextStyle,
                          ).build(),
                        ],
                      ),
                      SizedBox(height: Sizes.dynamicHeight(1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Point Change',
                            style: AppTextStyles.boldTextStyle,
                          ),
                          BuildColoredText(
                            text: index.index[0].index.toString(),
                            value: index.index[0].percentageChange,
                            textStyle: AppTextStyles.normalTextStyle,
                          ).build(),
                        ],
                      ),
                      SizedBox(height: Sizes.dynamicHeight(1.2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Turnover',
                            style: AppTextStyles.boldTextStyle,
                          ),
                          Text(
                            "Rs ${index.index[0].turnover}",
                            style: AppTextStyles.normalTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: AppTheme.getBorderColor(context),
                  width: 0.1,
                ),
              ),
            ),
            Text.rich(
              TextSpan(
                text: 'My Summary',
                style: AppTextStyles.titleTextStyle,
                children: state.isLoading
                    ? []
                    : [
                        TextSpan(
                          text:
                              '(${PortfolioStrings.asOf}${index.index[0].date.toString()})',
                          style: AppTextStyles.subTextStyle,
                        ),
                      ],
              ),
            ),
            SizedBox(height: Sizes.dynamicHeight(1.4)),
            (portfolios.isEmpty ||
                    portfolios.every((portfolio) => portfolio.isStockEmpty))
                ? const Center(child: EmptyAssetsWidget())
                : state.isLoading
                    ? SizedBox(
                        height: Sizes.dynamicHeight(30),
                        child: const Center(
                            child: LoadingIndicatorWidget(
                          size: 40,
                          showText: false,
                          text: PortfolioStrings.loadingPortfolios,
                        )))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Portfolio Value',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              Text(
                                'Rs ${state.portfolioDataEntity.totalPortfolioValue}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Top Portfolio Cost',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              Text(
                                'Rs ${state.portfolioDataEntity.totalPortfolioCost}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Your balance in wallet',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              Text(
                                'Rs ${auth.userAmount}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Portfolio P&L %',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              BuildColoredText(
                                text: state.portfolioDataEntity
                                    .totalPortfolioReturnsPercentage
                                    .toString(),
                                value: state.portfolioDataEntity
                                    .totalPortfolioReturnsPercentage,
                                textStyle: AppTextStyles.normalTextStyle,
                              ).build(),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Portfolio Returns',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              BuildColoredText(
                                text:
                                    'Rs ${state.portfolioDataEntity.totalPortfolioReturns.toStringAsFixed(1)}',
                                value: state
                                    .portfolioDataEntity.totalPortfolioReturns,
                                textStyle: AppTextStyles.normalTextStyle,
                              ).build(),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Portfolios',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              Text(
                                state.portfolioDataEntity.portfolioCount
                                    .toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Stocks',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              Text(
                                state.portfolioDataEntity.totalStocks
                                    .toString(),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Units',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              Text(
                                  state.portfolioDataEntity.totalUnits
                                      .toString(),
                                  style: Theme.of(context).textTheme.bodySmall),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Watchlist',
                                style: AppTextStyles.boldTextStyle,
                              ),
                              Text(
                                '${watchlist.watchlist.length}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                          SizedBox(height: Sizes.dynamicHeight(1.2)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '* Please visit portfolio page for more details',
                                style: AppTextStyles.boldTextStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
