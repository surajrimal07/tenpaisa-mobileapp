import 'package:paisa/feathures/home/domain/entity/world_market_entity.dart';

class WorldMarketState {
  final bool isLoading;
  final WorldMarketEntity worldMarket;
  final bool showMessage;
  final String error;

  WorldMarketState({
    this.isLoading = false,
    this.worldMarket = WorldMarketEntity.dummy,
    this.error = '',
    this.showMessage = false,
  });

  factory WorldMarketState.initialState() => WorldMarketState(
      isLoading: false,
      worldMarket: WorldMarketEntity.dummy,
      error: '',
      showMessage: false);

  WorldMarketState copyWith({
    bool? isLoading,
    WorldMarketEntity? worldMarket,
    bool? showMessage,
    String? error,
  }) {
    return WorldMarketState(
        isLoading: isLoading ?? this.isLoading,
        worldMarket: worldMarket ?? this.worldMarket,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage);
  }
}
