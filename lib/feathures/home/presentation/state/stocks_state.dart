import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';

class StocksState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<StockEntity> stocks;

  StocksState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.stocks,
  });

  factory StocksState.initialState() => StocksState(
        isLoading: false,
        error: null,
        showMessage: false,
        stocks: [],
      );

  StocksState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<StockEntity>? stocks,
  }) {
    return StocksState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        stocks: stocks ?? this.stocks);
  }
}
