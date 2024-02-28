import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/feathures/home/domain/entity/stock_entity.dart';
import 'package:paisa/feathures/home/domain/usecase/stock_usecase.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/stock_view_model.dart';

import '../../test_data/stock_entity_test.dart';
import 'stocks_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetStockUseCase>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late GetStockUseCase mockStockUseCase;
  late ProviderContainer container;
  late List<StockEntity> stockData;

  setUpAll(() async {
    mockStockUseCase = MockGetStockUseCase();
    stockData = await getStockEntityTest();
    when(mockStockUseCase.getAllStocks(false))
        .thenAnswer((realInvocation) => Future.value(const Right([])));
    container = ProviderContainer(overrides: [
      stockViewModelProvider.overrideWith(
        ((ref) => StockViewModel(getStockUseCase: mockStockUseCase)),
      ),
    ]);
  });

  test('check initial state', () {
    final stockState = container.read(stockViewModelProvider);
    expect(stockState.isLoading, true);
    expect(stockState.stocks, isEmpty);
    expect(stockState.error, isNull);
  });

  test('get watchlist and watchlist length', () async {
    when(mockStockUseCase.getAllStocks(false))
        .thenAnswer((realInvocation) => Future.value(Right(stockData)));

    await container.read(stockViewModelProvider.notifier).getStocks();

    final stockState = container.read(stockViewModelProvider);

    expect(stockState.stocks, stockData);
  });

  test('get stock length', () async {
    when(mockStockUseCase.getAllStocks(false))
        .thenAnswer((realInvocation) => Future.value(Right(stockData)));

    await container.read(stockViewModelProvider.notifier).getStocks();

    final stockState = container.read(stockViewModelProvider);

    expect(stockState.stocks.length, 302);
  });
}
