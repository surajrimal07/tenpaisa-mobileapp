import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/config/themes/app_text_styles.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/color_widget.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_stocks.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/find_stockentity.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/popmenubutton_widget.dart';

class PortfolioListContainer extends ConsumerWidget {
  final PortfolioEntity portfolio;
  final bool fromPortfolio;

  const PortfolioListContainer(
      {required this.portfolio, required this.fromPortfolio, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lastRecord = portfolio.gainLossRecords![0].portgainloss;

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
                        portfolio.name,
                        style: AppTextStyles.text17w600,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(width: Sizes.dynamicWidth(3)),
                      lastRecord != 0
                          ? Text(
                              //remove .abs() and add -ve sign in backend json
                              '${lastRecord > 0 ? 'Profit' : 'Loss'}: Rs ${lastRecord.abs().toStringAsFixed(0)}',
                              style: AppTextStyles.normalTextStyle,
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),
                if (fromPortfolio)
                  PopupMenu(fromPortfolio: fromPortfolio, portfolio: portfolio),
              ],
            ),
            if (portfolio.stocks?.isNotEmpty ?? false)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (fromPortfolio)
                    Text(
                      '${PortfolioStrings.recommendation} ${portfolio.recommendation}',
                      style: AppTextStyles.itemtext4,
                    ),
                  if (fromPortfolio)
                    Text(
                      //add stock count in backend json
                      ' You have ${portfolio.stocks!.length} Stocks with ${portfolio.totalunits} units',
                      style: AppTextStyles.itemtext4,
                    ),
                  DataTable(
                    dividerThickness: 0,
                    horizontalMargin: 0,
                    columnSpacing: 10,
                    columns: [
                      DataColumn(
                        label: SizedBox(
                          width: Sizes.dynamicHeight(9),
                          child: Text(
                            PortfolioStrings.symbolText,
                            style: AppTextStyles.normal600,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: Sizes.dynamicHeight(7),
                          child: Text(
                            PortfolioStrings.waccText,
                            style: AppTextStyles.normal600,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: 50,
                          child: Text(
                            PortfolioStrings.ltpText,
                            style: AppTextStyles.normal600,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: Sizes.dynamicHeight(7),
                          child: Text(
                            PortfolioStrings.valueTxt,
                            style: AppTextStyles.normal600,
                          ),
                        ),
                      ),
                      DataColumn(
                        label: SizedBox(
                          width: Sizes.dynamicHeight(10),
                          child: Text(
                            PortfolioStrings.quantityText,
                            style: AppTextStyles.normal600,
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
                                //optimize this
                                stock.symbol,
                                style: AppTextStyles.normal15,
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stock.wacc}',
                                style: AppTextStyles.normal15,
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stock.ltp}',
                                style: AppTextStyles.normal15,
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stock.currentPrice}',
                                style: AppTextStyles.normal15,
                              ),
                            ),
                            DataCell(
                              Text(
                                '${stock.quantity}',
                                style: AppTextStyles.normal15,
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

  DataCell buildDataCell(String text) {
    return DataCell(
      Text(
        text,
        style: AppTextStyles.normal15,
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
