import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';

class CommodityState {
  final bool isLoading;
  final String? error;
  final bool showMessage;
  final List<CommodityEntity> commodity;

  CommodityState({
    required this.isLoading,
    this.error,
    required this.showMessage,
    required this.commodity,
  });

  factory CommodityState.initialState() => CommodityState(
        isLoading: false,
        error: null,
        showMessage: false,
        commodity: [],
      );

  CommodityState copyWith({
    bool? isLoading,
    String? error,
    bool? showMessage,
    List<CommodityEntity>? commodity,
  }) {
    return CommodityState(
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
        showMessage: showMessage ?? this.showMessage,
        commodity: commodity ?? this.commodity);
  }
}
