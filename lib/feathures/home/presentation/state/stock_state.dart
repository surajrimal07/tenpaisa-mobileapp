import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';

class StockState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final StockEntity stock;

  StockState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.stock,
  });

  factory StockState.initialState() => StockState(
        isLoading: false,
        error: null,
        showMessage: false,
        stock: const StockEntity(
          symbol: 'Null',
          ltp: 0,
          pointChange: 0.0,
          percentChange: 0.0,
          open: 0,
          high: 0,
          low: 0,
          volume: 0,
          previousClose: 0,
          name: 'Null',
          category: 'Null',
          sector: 'Null',
          turnover: 0,
          day120: 0,
          day180: 0,
          week52High: 0,
          week52Low: 0,
        ),
      );

  StockState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    StockEntity? stock,
  }) {
    return StockState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        stock: stock ?? this.stock);
  }
}
