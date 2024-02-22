import 'package:flutter/material.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/portfolios_chart_widget.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StocksChartCard extends StatelessWidget {
  final List<UserPortfolioStockEntity> stocks;
  final String title;

  const StocksChartCard({
    required this.stocks,
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final List<dynamic> data = [];
    switch (title) {
      case PortfolioStrings.highestReturns:
        for (var stock in stocks) {
          data.add([stock.symbol, stock.netGainLoss]);
        }
        data.sort((a, b) => b[1].compareTo(a[1]));
        return _buildBarChart(data, isDarkMode);
      case PortfolioStrings.currentValueWeightage:
        final List<MapEntry<String, double>> stockValue = [];
        for (var stock in stocks) {
          stockValue.add(MapEntry(stock.symbol, stock.currentPrice));
        }
        stockValue.sort((a, b) => b.value.compareTo(a.value));
        final List<MapEntry<String, double>> topStocks =
            stockValue.take(5).toList();
        return _buildPieChart(topStocks, isDarkMode, isPercentage: true);
      case PortfolioStrings.portfolioCostWeightage:
        final Map<String, double> stockCosts = {};
        for (var stock in stocks) {
          stockCosts[stock.symbol] = stock.wacc;
        }
        List<MapEntry<String, double>> sortedStocks =
            stockCosts.entries.toList();
        sortedStocks.sort((a, b) => b.value.compareTo(a.value));
        final List<MapEntry<String, double>> topCostStocks =
            sortedStocks.take(10).toList();
        return _buildPieChart(topCostStocks, isDarkMode, isPercentage: false);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildBarChart(List<dynamic> data, bool isDarkMode) {
    return Card(
      margin: EdgeInsets.zero,
      color: isDarkMode
          ? const Color.fromARGB(255, 61, 86, 80)
          : const Color.fromARGB(255, 179, 178, 178),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: Sizes.dynamicHeight(36),
                    child: SfCartesianChart(
                      primaryXAxis: const CategoryAxis(
                        labelStyle: TextStyle(color: Colors.black),
                        majorGridLines:
                            MajorGridLines(color: Colors.transparent),
                      ),
                      primaryYAxis: const NumericAxis(
                        labelStyle: TextStyle(color: Colors.black),
                        majorGridLines:
                            MajorGridLines(color: Colors.transparent),
                      ),
                      plotAreaBorderColor: Colors.transparent,
                      enableAxisAnimation: true,
                      margin: const EdgeInsets.all(5),
                      title: ChartTitle(text: title),
                      legend: const Legend(isVisible: false),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: <CartesianSeries>[
                        BarSeries<dynamic, String>(
                          dataSource: data,
                          xValueMapper: (dynamic returns, _) => returns[0],
                          yValueMapper: (dynamic returns, _) => returns[1],
                          name: PortfolioStrings.returnsText,
                          dataLabelSettings:
                              const DataLabelSettings(isVisible: true),
                          pointColorMapper: (dynamic returns, _) {
                            return chartColors[
                                data.indexOf(returns) % chartColors.length];
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPieChart(List<MapEntry<String, double>> data, bool isDarkMode,
      {required bool isPercentage}) {
    return Card(
      margin: EdgeInsets.zero,
      color: isDarkMode
          ? const Color.fromARGB(255, 61, 86, 80)
          : const Color.fromARGB(255, 179, 178, 178),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: Sizes.dynamicHeight(36),
              child: SfCircularChart(
                margin: const EdgeInsets.all(0),
                title: ChartTitle(text: title),
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                  color: Colors.grey[700],
                ),
                series: <CircularSeries>[
                  PieSeries<MapEntry<String, double>, String>(
                    dataSource: data,
                    xValueMapper: (MapEntry<String, double> data, _) =>
                        data.key,
                    yValueMapper: (MapEntry<String, double> data, _) =>
                        data.value,
                    dataLabelMapper: (MapEntry<String, double> data, _) =>
                        isPercentage
                            ? '${data.key}\n${(data.value / stocks.map((e) => e.currentPrice).reduce((a, b) => a + b) * 100).toStringAsFixed(2)}%'
                            : '${data.key}\n${data.value.toStringAsFixed(2)}',
                    dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      labelPosition: ChartDataLabelPosition.outside,
                      showZeroValue: false,
                      showCumulativeValues: true,
                      textStyle: TextStyle(
                        color: isDarkMode ? Colors.white : Colors.black,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
