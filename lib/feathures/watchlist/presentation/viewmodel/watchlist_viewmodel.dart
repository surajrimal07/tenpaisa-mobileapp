import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/addstock_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/create_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/delete_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/get_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/removestock_wathlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/rename_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/presentation/state/watchlist_state.dart';

final watchlistViewModelProvider =
    StateNotifierProvider<WatchlistViewModel, WatchlistState>(
  (ref) => WatchlistViewModel(
      getwatchlistUseCase: ref.watch(getWatchlistUsecaseProvider),
      createWatchlistUsecase: ref.watch(createWatchlistUsecaseProvider),
      deleteWatchlistUsecase: ref.watch(deleteWatchlistUsecaseProvider),
      renameWatchlistUsecase: ref.watch(renameWatchlistUsecaseProvider),
      addStockWatchlistUsecase: ref.watch(addStockWatchlistUsecaseProvider),
      removeStockWatchlistUseCase:
          ref.watch(removeStockWatchlistUsecaseProvider)),
);

class WatchlistViewModel extends StateNotifier<WatchlistState> {
  final GetWatchlistUsecase getwatchlistUseCase;
  CreateWatchlistUsecase createWatchlistUsecase;
  DeleteWatchlistUsecase deleteWatchlistUsecase;
  RenameWatchlistUsecase renameWatchlistUsecase;
  AddStockWatchlistUsecase addStockWatchlistUsecase;
  RemoveStockWatchlistUseCase removeStockWatchlistUseCase;

  WatchlistViewModel(
      {required this.getwatchlistUseCase,
      required this.createWatchlistUsecase,
      required this.deleteWatchlistUsecase,
      required this.renameWatchlistUsecase,
      required this.addStockWatchlistUsecase,
      required this.removeStockWatchlistUseCase})
      : super(WatchlistState.initial()) {
    getWatchlist();
  }

  Future<void> getWatchlist() async {
    state = state.copyWith(isLoading: true);
    var data = await getwatchlistUseCase.getWatchlist();
    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, error: failure.error, showMessage: true);
        //CustomToast.showToast(failure.error.toString());
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            watchlist: success,
            showMessage: true);
      },
    );
  }

  Future<void> createWatchlist(String name) async {
    state = state.copyWith(isLoading: true);
    var data = await createWatchlistUsecase.createWatchlist(name);
    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, error: failure.error, showMessage: true);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            watchlist: success,
            showMessage: true);
      },
    );
  }

  Future<void> deleteWatchlist(String watchlistId) async {
    state = state.copyWith(isLoading: true);
    var data = await deleteWatchlistUsecase.deleteWatchList(watchlistId);
    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, error: failure.error, showMessage: true);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            watchlist: success,
            showMessage: true);
      },
    );
  }

  Future<void> renameWatchlist(String watchlistId, String newName) async {
    state = state.copyWith(isLoading: true);
    var data =
        await renameWatchlistUsecase.renameWatchList(watchlistId, newName);
    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, error: failure.error, showMessage: true);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            watchlist: success,
            showMessage: true);
      },
    );
  }

  Future<void> addStockToWatchlist(String watchlistId, String stock) async {
    state = state.copyWith(isLoading: true);
    var data =
        await addStockWatchlistUsecase.addStockWatchList(watchlistId, stock);
    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, error: failure.error, showMessage: true);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            watchlist: success,
            showMessage: true);
      },
    );
  }

  Future<void> removeStockFromWatchlist(
      String watchlistId, String stock) async {
    state = state.copyWith(isLoading: true);
    var data = await removeStockWatchlistUseCase.removeStockWatchList(
        watchlistId, stock);
    data.fold(
      (failure) {
        state = state.copyWith(
            isLoading: false, error: failure.error, showMessage: true);
      },
      (success) {
        state = state.copyWith(
            isLoading: false,
            error: null,
            watchlist: success,
            showMessage: true);
      },
    );
  }
}
