import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/categories_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/world_market_viewmodel.dart';

Future<void> handleAllRefresh(WidgetRef ref) async {
  await Future.wait([
    ref.read(indexViewModelProvider.notifier).getIndex(true),
    ref.read(categoriesViewModelProvider.notifier).getCategories(true),
    ref.read(stockViewModelProvider.notifier).getStocks(true),
    ref.read(worldMarketViewModelProvider.notifier).getWorldMarket(true),
    // ref.watch(portfolioViewModelProvider.notifier).getPortfolio(),
  ]);
}
