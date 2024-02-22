// ignore_for_file: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';

StockEntity findStockDetails(String symbol, WidgetRef ref) {
  final stocksList = ref.watch(stockViewModelProvider.notifier).state.stocks;
  final stockEntity = stocksList.firstWhere(
    (stock) => stock.symbol == symbol,
    orElse: () => const StockEntity(
      symbol: 'Loading...',
      ltp: 0,
      pointChange: 0,
      percentChange: 0,
      open: 0,
      high: 0,
      low: 0,
      volume: 0,
      previousClose: 0,
      name: 'Loading...',
      category: 'Loading...',
      sector: 'Loading...',
    ),
  );
  return stockEntity;
}
