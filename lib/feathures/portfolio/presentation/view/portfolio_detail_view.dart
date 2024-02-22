// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view/portfolio_view.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/addstock_portfolio.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_stocks.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/popmenubutton_widget.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/portfolio_lists.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/stock_summary.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/stocks_chart.dart';

class PortfoliodetailView extends ConsumerWidget {
  final int portfolioIndex;

  const PortfoliodetailView({super.key, required this.portfolioIndex});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(indexViewModelProvider);
    ref.watch(portfolioViewModelProvider).portfoliosEntity;

    PortfolioEntity portfolio = ref
        .watch(portfolioViewModelProvider.notifier)
        .state
        .portfoliosEntity[portfolioIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${portfolio.name} details',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          PopupMenu(fromPortfolio: false, portfolio: portfolio),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.read(portfolioViewModelProvider.notifier).getPortfolio();
        },
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: !portfolio.isStockEmpty
                  ? Column(
                      children: [
                        SizedBox(
                          height: Sizes.dynamicHeight(0.5),
                        ),
                        _buildPageView(portfolio, index, ref, context),
                        PortfolioListContainer(
                            portfolio: portfolio, fromPortfolio: false)
                      ],
                    )
                  : Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: const EmptyAssetsWidget()),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await addStockPortfolio(context, portfolio.id, portfolio.name);
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(90.0),
        ),
        child: const Icon(Icons.add_outlined),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildPageView(PortfolioEntity portfolio, indexs, ref, context) {
    List<Widget> pageWidgets = [
      StocksSummaryCard(userPort: portfolio),
      StocksChartCard(
          title: PortfolioStrings.highestReturns, stocks: portfolio.stocks!),
      StocksChartCard(
          title: PortfolioStrings.portfolioCostWeightage,
          stocks: portfolio.stocks!),
      StocksChartCard(
          title: PortfolioStrings.currentValueWeightage,
          stocks: portfolio.stocks!),
    ];

    return Column(
      children: [
        SizedBox(
          height: Sizes.dynamicHeight(39),
          child: PageView.builder(
            onPageChanged: (int index) {
              ref.read(currentPageProvider.notifier).state = index;
            },
            itemCount: pageWidgets.length,
            itemBuilder: (BuildContext context, index) {
              return pageWidgets[index];
            },
          ),
        ),
        SizedBox(height: Sizes.dynamicHeight(0.7)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            pageWidgets.length,
            (index) => Container(
              width: Sizes.dynamicWidth(1.1),
              height: Sizes.dynamicHeight(0.6),
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ref.watch(currentPageProvider) == index
                    ? AppTheme.isDarkMode(context)
                        ? Colors.white
                        : Colors.black
                    : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> addStockPortfolio(
      BuildContext context, String id, String portfolioName) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddStockPortfolioDialog(
            portfolioId: id, portfolioName: portfolioName);
      },
    );
  }
}
