import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/feathures/watchlist/domain/entity/watchlist_entity.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/addstock_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/create_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/delete_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/get_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/removestock_wathlist_usecase.dart';
import 'package:paisa/feathures/watchlist/domain/usecase/rename_watchlist_usecase.dart';
import 'package:paisa/feathures/watchlist/presentation/viewmodel/watchlist_viewmodel.dart';

import '../../test_data/watchlist_index_test.dart';
import 'watchlist_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetWatchlistUsecase>(),
  MockSpec<CreateWatchlistUsecase>(),
  MockSpec<DeleteWatchlistUsecase>(),
  MockSpec<RenameWatchlistUsecase>(),
  MockSpec<AddStockWatchlistUsecase>(),
  MockSpec<RemoveStockWatchlistUseCase>()
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late GetWatchlistUsecase mockWatchlistUseCase;
  late CreateWatchlistUsecase mockCreateWatchlistUsecase;
  late DeleteWatchlistUsecase mockDeleteWatchlistUsecase;
  late RenameWatchlistUsecase mockRenameWatchlistUsecase;
  late AddStockWatchlistUsecase mockAddStockWatchlistUsecase;
  late RemoveStockWatchlistUseCase mockRemoveStockWatchlistUseCase;
  late ProviderContainer container;
  late List<WatchlistEntity> watchlistData;

  setUpAll(() async {
    mockWatchlistUseCase = MockGetWatchlistUsecase();
    mockCreateWatchlistUsecase = MockCreateWatchlistUsecase();
    mockDeleteWatchlistUsecase = MockDeleteWatchlistUsecase();
    mockRenameWatchlistUsecase = MockRenameWatchlistUsecase();
    mockAddStockWatchlistUsecase = MockAddStockWatchlistUsecase();
    mockRemoveStockWatchlistUseCase = MockRemoveStockWatchlistUseCase();

    watchlistData = await getWatchlistEntityTest();
    when(mockWatchlistUseCase.getWatchlist())
        .thenAnswer((realInvocation) => Future.value(const Right([])));
    container = ProviderContainer(overrides: [
      watchlistViewModelProvider.overrideWith(
        ((ref) => WatchlistViewModel(
            getwatchlistUseCase: mockWatchlistUseCase,
            createWatchlistUsecase: mockCreateWatchlistUsecase,
            deleteWatchlistUsecase: mockDeleteWatchlistUsecase,
            renameWatchlistUsecase: mockRenameWatchlistUsecase,
            addStockWatchlistUsecase: mockAddStockWatchlistUsecase,
            removeStockWatchlistUseCase: mockRemoveStockWatchlistUseCase)),
      ),
    ]);
  });

  test('check initial state', () {
    final watchlistState = container.read(watchlistViewModelProvider);
    expect(watchlistState.isLoading, true);
    expect(watchlistState.watchlist, isEmpty);
    expect(watchlistState.error, isNull);
  });

  test('get watchlist and watchlist length', () async {
    when(mockWatchlistUseCase.getWatchlist())
        .thenAnswer((realInvocation) => Future.value(Right(watchlistData)));

    await container.read(watchlistViewModelProvider.notifier).getWatchlist();

    final watchlistState = container.read(watchlistViewModelProvider);

    expect(watchlistState.watchlist, watchlistData);
  });

  test('get watchlist length', () async {
    when(mockWatchlistUseCase.getWatchlist())
        .thenAnswer((realInvocation) => Future.value(Right(watchlistData)));

    await container.read(watchlistViewModelProvider.notifier).getWatchlist();

    final watchlistState = container.read(watchlistViewModelProvider);

    expect(watchlistState.watchlist.length, 6);
  });

  test('add watchlist', () async {
    when(mockCreateWatchlistUsecase.createWatchlist("watchlist"))
        .thenAnswer((realInvocation) => Future.value(Right(watchlistData)));

    await container
        .read(watchlistViewModelProvider.notifier)
        .createWatchlist("watchlist");

    final watchlistState = container.read(watchlistViewModelProvider);

    expect(watchlistState.watchlist.length, 6);
  });
}
