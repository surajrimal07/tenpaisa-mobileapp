// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/color_widget.dart';

class PortfolioSummaryCard extends ConsumerWidget {
  const PortfolioSummaryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final calculatePortfoliosData = ref
        .watch(portfolioViewModelProvider.notifier)
        .state
        .portfolioDataEntity;
    final index = ref.watch(indexViewModelProvider);

    return Card(
      margin: const EdgeInsets.all(0),
      color: ref.read(colorProvider)(
          context, calculatePortfoliosData.totalPortfolioReturns),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: PortfolioStrings.summaryText,
                      style: TextStyle(
                        color: AppTheme.isDarkMode(context)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    TextSpan(
                      text:
                          ' (${PortfolioStrings.asOf}${index.index[0].date.toString()})',
                      style: TextStyle(
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                        color: AppTheme.isDarkMode(context)
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Sizes.dynamicHeight(1.3)),
              Text(
                '${PortfolioStrings.numberOfPortfolios} ${calculatePortfoliosData.portfolioCount}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${PortfolioStrings.totalPortfolioCost}${calculatePortfoliosData.totalPortfolioCost.toStringAsFixed(1)} ',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${PortfolioStrings.totalPortfolioValue} ${calculatePortfoliosData.totalPortfolioValue}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${PortfolioStrings.totalStocks}${calculatePortfoliosData.totalStocks}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${PortfolioStrings.totalUnits} ${calculatePortfoliosData.totalUnits}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${PortfolioStrings.totalPortfolioReturns}${calculatePortfoliosData.totalPortfolioReturns.toStringAsFixed(1)} (${calculatePortfoliosData.totalPortfolioReturnsPercentage.toStringAsFixed(1)}%)',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${PortfolioStrings.recommendation} ${calculatePortfoliosData.recommendation}',
                style:
                    const TextStyle(overflow: TextOverflow.fade, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
