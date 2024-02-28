import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/portfolio/data/dto/get_portfolio_dto.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/addstock_portfolio.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/create_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/delete_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/deletestockfrom_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/get_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/domain/usecase/rename_portfolio_usecase.dart';
import 'package:paisa/feathures/portfolio/presentation/view_model/portfolio_view_model.dart';

import '../../test_data/portfolio_index.dart';
import 'portfolio_unit_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GetPortfolioUseCase>(),
  MockSpec<AddPortfolioUseCase>(),
  MockSpec<DeletePortfolioUseCase>(),
  MockSpec<RenamePortfolioUseCase>(),
  MockSpec<AddStockToPortfolioUseCase>(),
  MockSpec<RemoveStockToPortfolioUseCase>()
])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late GetPortfolioUseCase mockPortfolioUseCase;
  late AddPortfolioUseCase mockPortfolioUsecase;
  late DeletePortfolioUseCase mockDeletePortfolioUsecase;
  late RenamePortfolioUseCase mockRenamePortfolioUsecase;
  late AddStockToPortfolioUseCase mockAddStockPortfolioUsecase;
  late RemoveStockToPortfolioUseCase mockRemoveStockPortfolioUseCase;
  late ProviderContainer container;
  late PortfolioCombined watchlistData;

  setUpAll(() async {
    mockPortfolioUseCase = MockGetPortfolioUseCase();
    mockPortfolioUsecase = MockAddPortfolioUseCase();
    mockDeletePortfolioUsecase = MockDeletePortfolioUseCase();
    mockRenamePortfolioUsecase = MockRenamePortfolioUseCase();
    mockAddStockPortfolioUsecase = MockAddStockToPortfolioUseCase();
    mockRemoveStockPortfolioUseCase = MockRemoveStockToPortfolioUseCase();

    watchlistData = await getPortfolioEntityTest();
    when(mockPortfolioUseCase.getportfolio()).thenAnswer(
        (realInvocation) => Future.value(Left(Failure(error: "error"))));
    container = ProviderContainer(overrides: [
      portfolioViewModelProvider.overrideWith(
        ((ref) => PortfolioViewModel(
            getPortfolioUsecase: mockPortfolioUseCase,
            createPortfolioUseCase: mockPortfolioUsecase,
            deletePortfolioUseCase: mockDeletePortfolioUsecase,
            renamePortfolioUseCase: mockRenamePortfolioUsecase,
            addStockToPortfolioUseCase: mockAddStockPortfolioUsecase,
            removeStockToPortfolioUseCase: mockRemoveStockPortfolioUseCase)),
      ),
    ]);
  });

  test('check initial state', () {
    final portfolioState = container.read(portfolioViewModelProvider);
    expect(portfolioState.isLoading, true);
    expect(portfolioState.portfoliosEntity, isEmpty);
    expect(portfolioState.error, isNull);
  });

  test('get portfolioEntity and portfolio length', () async {
    when(mockPortfolioUseCase.getportfolio())
        .thenAnswer((realInvocation) => Future.value(Right(watchlistData)));

    await container.read(portfolioViewModelProvider.notifier).getPortfolio();

    final portfolioState = container.read(portfolioViewModelProvider);

    expect(portfolioState.portfoliosEntity, watchlistData.portfolioEntityList);
    expect(portfolioState.portfoliosEntity.length, 22);
  });

  test('get portfolioData and length', () async {
    when(mockPortfolioUseCase.getportfolio())
        .thenAnswer((realInvocation) => Future.value(Right(watchlistData)));

    await container.read(portfolioViewModelProvider.notifier).getPortfolio();

    final portfolioState = container.read(portfolioViewModelProvider);

    expect(
        portfolioState.portfolioDataEntity, watchlistData.portfolioDataEntity);
  });
}
