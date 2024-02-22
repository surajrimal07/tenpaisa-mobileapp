import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/color_widget.dart';

class StocksSummaryCard extends ConsumerWidget {
  final PortfolioEntity userPort;

  const StocksSummaryCard({super.key, required this.userPort});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexViewModelProvider);
    final userStocks = userPort.stocks!;
    final netGains =
        userStocks.map((e) => e.netGainLoss).reduce((a, b) => a + b);
    final totalStocks = userStocks.length;

    final totalPortfolioCost =
        userStocks.map((e) => e.costPrice * e.quantity).reduce((a, b) => a + b);

    final totalPortfolioValue = userStocks
        .map((e) => e.currentPrice * e.quantity)
        .reduce((a, b) => a + b);

    final totalProfitLoss = totalPortfolioValue - totalPortfolioCost;

    return Card(
      margin: const EdgeInsets.all(0),
      color: ref.read(colorProvider)(context, netGains.toInt()),
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
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text: PortfolioStrings.summaryText,
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
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
                        color: Theme.of(context).brightness == Brightness.dark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Sizes.dynamicHeight(0.6)),
              Text(
                'Stocks: $totalStocks',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Cost: Rs ${userPort.portfoliocost}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Value: Rs ${userPort.portfoliovalue}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Units: ${userPort.totalunits}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Potfolio Goal: ${userPort.portfolioGoal}',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                'Potfolio P&L: Rs $totalProfitLoss (${userPort.percentage}%)',
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                '${PortfolioStrings.recommendation}${userPort.recommendation}',
                style: const TextStyle(
                  overflow: TextOverflow.fade,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
