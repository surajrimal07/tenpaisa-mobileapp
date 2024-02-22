// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/constants/appsize_constants.dart';
import 'package:paisa/config/themes/app_themes.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/common/loading_indicator.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/add_portfolio.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/empty_portfolio.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/portfolio_dialog.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/portfolio_lists.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/portfolio_summary.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/portfolios_chart_widget.dart';

final currentPageProvider =
    StateNotifierProvider<CurrentPageNotifier, int>((ref) {
  return CurrentPageNotifier();
});

class CurrentPageNotifier extends StateNotifier<int> {
  CurrentPageNotifier() : super(0);
}

class PortfolioView extends ConsumerWidget {
  const PortfolioView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(portfolioViewModelProvider);
    final index = ref.watch(indexViewModelProvider);
    final portfolios =
        ref.watch(portfolioViewModelProvider.notifier).state.portfoliosEntity;

    return Scaffold(
      appBar: AppBar(
        title: const Text(PortfolioStrings.portfolioText),
        toolbarHeight: Sizes.dynamicHeight(6),
        actions: [
          IconButton(
            onPressed: () {
              _showMenu(context);
            },
            icon: const Icon(Icons.menu),
          ),
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
              child: state.isLoading
                  ? const Center(
                      widthFactor: 5,
                      heightFactor: 7,
                      child: LoadingIndicatorWidget(
                        size: 50,
                        showText: true,
                        text: PortfolioStrings.loadingPortfolios,
                      ))
                  : portfolios.isEmpty
                      ? const Center(
                          widthFactor: 5,
                          heightFactor: 4,
                          child: EmptyPortfolioWidget())
                      : Column(
                          children: [
                            _buildPageView(portfolios, index, ref, context),
                            for (var portfolio in portfolios)
                              PortfolioListContainer(
                                  portfolio: portfolio, fromPortfolio: true)
                          ],
                        ),
            ),
          ),
        ),
      ),
    );
  }

  void _showMenu(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context).context.findRenderObject() as RenderBox;
    final Offset position =
        button.localToGlobal(Offset(button.size.width, 0), ancestor: overlay);

    final List<PopupMenuEntry<String>> menuItems = [
      PopupMenuItem<String>(
        onTap: () => showCreatePortfolio(context),
        value: 'createPortfolio',
        child: const Row(
          children: [
            Text(PortfolioStrings.createPortfolioText),
          ],
        ),
      ),
      PopupMenuItem<String>(
        value: 'addStock',
        onTap: () => showdAddFromFloating(context),
        child: const Row(
          children: [
            Text(PortfolioStrings.addStockText),
          ],
        ),
      ),
    ];

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        overlay.size.width - position.dx,
        overlay.size.height - position.dy,
      ),
      items: menuItems,
    );
  }

  Widget _buildPageView(List<PortfolioEntity> portfolios, indexs, WidgetRef ref,
      BuildContext context) {
    List<Widget> pageWidgets = [
      const PortfolioSummaryCard(),
      _buildCustomChartCard(
          'Portfolio Value Weightage', portfolios, ref, context),
      _buildCustomChartCard(
          'Portfolio Cost Weightage', portfolios, ref, context),
      _buildCustomChartCard(
          'Portfolio Unit Weightage', portfolios, ref, context),
      _buildCustomChartCard('Portfolio Returns', portfolios, ref, context),
      _buildCustomChartCard('Portfolio Stocks Count', portfolios, ref, context),
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
        SizedBox(height: Sizes.dynamicHeight(1)),
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

  Future<void> showdAddFromFloating(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddStockFloatingDialog();
      },
    );
  }

  Future<void> showCreatePortfolio(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CreatePortfolioDialog();
      },
    );
  }

  Widget _buildCustomChartCard(String title, List<PortfolioEntity> portfolios,
      WidgetRef ref, BuildContext context) {
    final calculatePortfoliosData = ref
        .watch(portfolioViewModelProvider.notifier)
        .state
        .portfolioDataEntity;
    num totalPortfolioCost = calculatePortfoliosData.totalPortfolioCost;

    Map<String, double> dataMap = {};

    switch (title) {
      case 'Portfolio Cost Weightage':
        for (var portfolio in portfolios) {
          double weightage =
              (portfolio.portfoliocost ?? 0) / totalPortfolioCost;
          dataMap[portfolio.name] = weightage;
        }
        break;
      case 'Portfolio Unit Weightage':
        int totalPortfolioUnits = calculatePortfoliosData.totalUnits;
        for (var portfolio in portfolios) {
          double weightage = (portfolio.totalunits ?? 0) / totalPortfolioUnits;
          dataMap[portfolio.name] = weightage;
        }
        break;
      case 'Portfolio Returns':
        num totalPortfolioValue = calculatePortfoliosData.totalPortfolioValue;
        num totalReturns = totalPortfolioValue - totalPortfolioCost;
        for (var portfolio in portfolios) {
          double weightage = ((portfolio.portfoliovalue ?? 0) -
                  (portfolio.portfoliocost ?? 0)) /
              totalReturns;
          dataMap[portfolio.name] = weightage;
        }
        break;
      case 'Portfolio Value Weightage':
      default:
        for (var portfolio in portfolios) {
          double weightage =
              (portfolio.portfoliovalue ?? 0) / totalPortfolioCost;
          dataMap[portfolio.name] = weightage;
        }
        break;
    }

    return CommonPortfolioCard(
      title: title,
      dataMap: dataMap,
      isDarkMode: AppTheme.isDarkMode(context),
    );
  }
}
