import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/color_widget.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_stocks.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/find_stockentity.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/popmenubutton_widget.dart';

// final sortAscendingProvider = StateProvider<bool>((ref) => true);
// final sortColumnIndexProvider = StateProvider<int>((ref) => 0);

class PortfolioListContainer extends ConsumerWidget {
  final PortfolioEntity portfolio;
  final bool fromPortfolio;

  const PortfolioListContainer(
      {required this.portfolio, required this.fromPortfolio, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastRecord = portfolio.portfoliovalue! - portfolio.portfoliocost!;
    // final sortAscending = ref.watch(sortAscendingProvider);
    // final sortColumnIndex = ref.watch(sortColumnIndexProvider);

    return GestureDetector(
      onTap: () {
        if (fromPortfolio) {
          final int portfolioIndex = ref
              .watch(portfolioViewModelProvider)
              .portfoliosEntity
              .indexOf(portfolio);

          ref.watch(navigationServiceProvider).routeTo(
            '/portfolioDetailView',
            arguments: {'portfolioIndex': portfolioIndex},
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(left: 0, right: 0, top: 3, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.black,
            width: 0.1,
          ),
          color: ref.watch(colorProvider)(context, lastRecord),
        ),
        padding: const EdgeInsets.only(left: 10, right: 10, top: 2, bottom: 5),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (fromPortfolio)
                  Row(
                    children: [
                      Text(
                        portfolio.name.length <= 12
                            ? portfolio.name
                            : '${portfolio.name.substring(0, 12)}...',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: Sizes.dynamicWidth(3)),
                      Text(
                        lastRecord != 0
                            ? lastRecord > 0
                                ? 'Profit: Rs ${((lastRecord * 100).round() / 100)}'
                                : 'Loss: Rs ${((lastRecord * 100).round() / 100)}'
                            : '',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                        ),
                      )
                    ],
                  ),
                if (fromPortfolio)
                  PopupMenu(fromPortfolio: fromPortfolio, portfolio: portfolio),
              ],
            ),
            if (portfolio.stocks?.isNotEmpty ?? false)
              Column(
                children: [
                  if (fromPortfolio)
                    Text(
                      '${PortfolioStrings.recommendation} ${portfolio.recommendation}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (fromPortfolio)
                    Text(
                      ' You have ${portfolio.stocks!.length} Stocks with ${portfolio.totalunits} units',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  DataTable(
                    dividerThickness: 0,
                    horizontalMargin: 0,
                    columnSpacing: 10,
                    // sortAscending: sortAscending,
                    // sortColumnIndex: sortColumnIndex,
                    columns: [
                      DataColumn(
                        label: SizedBox(
                          width: Sizes.dynamicHeight(9),
                          child: const Text(
                            PortfolioStrings.symbolText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        //something is wrong with sorting
                        // onSort: (columnIndex, ascending) {
                        //   ref.read(sortAscendingProvider.notifier).state =
                        //       ascending;
                        //   ref.read(sortColumnIndexProvider.notifier).state =
                        //       columnIndex;
                        //   portfolio.stocks!.sort((a, b) =>
                        //       a.wacc.compareTo(b.wacc) * (ascending ? -1 : 1));
                        //   // portfolio.stocks!.sort((a, b) {
                        //   //   switch (columnIndex) {
                        //   //     case 1:
                        //   //       return a.wacc.compareTo(b.wacc) *
                        //   //           (ascending ? -1 : 1);
                        //   //     default:
                        //   //       return 0;
                        //   //   }
                        //   // });
                        // },
                        label: SizedBox(
                          width: Sizes.dynamicHeight(7),
                          child: const Text(
                            PortfolioStrings.waccText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const DataColumn(
                        label: SizedBox(
                          width: 50,
                          child: Text(
                            PortfolioStrings.ltpText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: Sizes.dynamicHeight(7),
                          child: const Text(
                            PortfolioStrings.valueTxt,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: Sizes.dynamicHeight(10),
                          child: const Text(
                            PortfolioStrings.quantityText,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                    rows: [
                      for (var stock in _getTopStocks(portfolio.stocks!))
                        DataRow(
                          cells: [
                            DataCell(
                              onTap: () async {
                                final stockEntity =
                                    findStockDetails(stock.symbol, ref);
                                ref.watch(navigationServiceProvider).routeTo(
                                    '/assetview',
                                    arguments: {'stockEntity': stockEntity});
                              },
                              Text(
                                stock.symbol,
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stock.wacc}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stock.ltp}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stock.currentPrice}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stock.quantity}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ],
              )
            else
              const EmptyAssetsWidget(),
          ],
        ),
      ),
    );
  }

  List<UserPortfolioStockEntity> _getTopStocks(
      List<UserPortfolioStockEntity> stocks) {
    if (fromPortfolio) {
      stocks.sort((a, b) =>
          (b.currentPrice * b.quantity).compareTo(a.currentPrice * a.quantity));
      return List<UserPortfolioStockEntity>.from(stocks.take(4));
    } else {
      stocks.sort((a, b) =>
          (b.currentPrice * b.quantity).compareTo(a.currentPrice * a.quantity));
      return stocks;
    }
  }
}
