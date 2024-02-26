import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/core/network/detector_network.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/categories_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/world_market_viewmodel.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

Future<void> handleAllRefresh(WidgetRef ref) async {
  final connectivity = ref.read(connectivityStatusProvider);
  if (connectivity == ConnectivityStatus.isDisconnected) {
    return;
  }
  await Future.wait([
    ref.read(indexViewModelProvider.notifier).getIndex(true),
    ref.read(categoriesViewModelProvider.notifier).getCategories(true),
    ref.read(stockViewModelProvider.notifier).getStocks(true),
    ref.read(worldMarketViewModelProvider.notifier).getWorldMarket(true),
    ref.watch(portfolioViewModelProvider.notifier).getPortfolio(),
  ]);
}
