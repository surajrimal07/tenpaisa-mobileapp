import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/core/utils/string_utils.dart';
import 'package:paisa/feathures/portfolio/domain/entity/portfolio_entity.dart';
import 'package:paisa/feathures/portfolio/domain/entity/userportfoliostock_entity.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/addstock_portfolio.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/delete_portfolio_dialog.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/deletestock_portfolio.dart';
import 'package:paisa/feathures/portfolio/presentation/widget/rename_portfolio_dialog.dart';

class PopupMenu extends ConsumerWidget {
  final bool fromPortfolio;
  final PortfolioEntity portfolio;

  const PopupMenu({
    required this.fromPortfolio,
    required this.portfolio,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem<String>(
            onTap: () => addStockPortfolio(
              context,
              portfolio.id,
              portfolio.name,
            ),
            value: 'addAsset',
            child: const Text(PortfolioStrings.addStockText),
          ),
          PopupMenuItem<String>(
            onTap: () => showStockDeletePortfolio(
              context,
              portfolio.id,
              portfolio.name,
              portfolio.stocks,
            ),
            value: 'removeAsset',
            child: const Text(PortfolioStrings.removeAsset),
          ),
          PopupMenuItem<String>(
            onTap: () => showdDeletePortfolio(
              context,
              portfolio.id,
              portfolio.name,
            ),
            value: 'deletePortfolio',
            child: const Text(PortfolioStrings.deletePortfolio),
          ),
          PopupMenuItem<String>(
            onTap: () => showRenamePortfolio(
              context,
              portfolio.id,
              portfolio.name,
            ),
            value: 'rename',
            child: const Text(PortfolioStrings.renamePortfolio),
          ),
          if (fromPortfolio)
            PopupMenuItem<String>(
              onTap: () {
                final int portfolioIndex = ref
                    .watch(portfolioViewModelProvider)
                    .portfoliosEntity
                    .indexOf(portfolio);

                ref
                    .watch(navigationServiceProvider)
                    .routeTo('/portfolioDetailView', arguments: {
                  'portfolioIndex': portfolioIndex,
                });
              },
              value: 'view',
              child: const Text(PortfolioStrings.viewPortfolio),
            ),
          PopupMenuItem<String>(
            onTap: () {
              ref.read(navigationServiceProvider).routeTo(
                '/compare',
                arguments: {'selectedPortfolio1': portfolio},
              );
            },
            value: 'comparePortfolio',
            child: const Text(PortfolioStrings.comparePortfolio),
          ),
        ];
      },
    );
  }

  Future<void> addStockPortfolio(
    BuildContext context,
    String id,
    String portfolioName,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddStockPortfolioDialog(
          portfolioId: id,
          portfolioName: portfolioName,
        );
      },
    );
  }

  Future<void> showdDeletePortfolio(
    BuildContext context,
    String id,
    String portfolioName,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeletePortfolioDialog(
          portfolioId: id,
          portfolioName: portfolioName,
        );
      },
    );
  }

  Future<void> showStockDeletePortfolio(
    BuildContext context,
    String id,
    String portfolioName,
    List<UserPortfolioStockEntity>? stocks,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteStockPortfolioDialog(
          portfolioId: id,
          portfolioName: portfolioName,
          stocksInPortfolio: stocks,
        );
      },
    );
  }

  Future<void> showRenamePortfolio(
    BuildContext context,
    String id,
    String name,
  ) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RenamePortfolioDialog(
          portfolioId: id,
          oldPortfolioName: name,
        );
      },
    );
  }
}
