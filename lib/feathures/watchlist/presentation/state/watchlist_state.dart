import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';

class WatchlistState {
  final List<WatchlistEntity> watchlist;
  final bool isLoading;
  final String? error;
  final bool showMessage;

  WatchlistState({
    required this.watchlist,
    required this.isLoading,
    this.error,
    required this.showMessage,
  });

  factory WatchlistState.initial() {
    return WatchlistState(
      watchlist: [],
      isLoading: false,
      error: null,
      showMessage: false,
    );
  }

  WatchlistState copyWith({
    List<WatchlistEntity>? watchlist,
    bool? isLoading,
    String? error,
    bool? showMessage,
  }) {
    return WatchlistState(
      watchlist: watchlist ?? this.watchlist,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      showMessage: showMessage ?? this.showMessage,
    );
  }

  bool get isWatchlistEmpty {
    return watchlist.isEmpty;
  }

  bool get isWatchlistNotEmpty {
    return watchlist.isNotEmpty;
  }

  int get watchlistLength {
    return watchlist.length;
  }

  int get stockListLength {
    int length = 0;
    for (var element in watchlist) {
      length += element.stocks.length;
    }
    return length;
  }
}
