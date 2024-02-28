import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/feathures/home/domain/entity/commodity_entity.dart';
import 'package:paisa/feathures/home/domain/usecase/commodity_usecase.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/commodity_view_model.dart';

import '../../test_data/commodity_entity_test.dart';
import 'commodity_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<CommodityUseCase>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late CommodityUseCase mockCommodityUseCase;
  late ProviderContainer container;
  late List<CommodityEntity> commodityData;

  setUpAll(() async {
    mockCommodityUseCase = MockCommodityUseCase();
    commodityData = await getCommodityEntityTest();
    when(mockCommodityUseCase.getCommodity())
        .thenAnswer((realInvocation) => Future.value(const Right([])));
    container = ProviderContainer(overrides: [
      commodityViewModelProvider.overrideWith(
        ((ref) => CommodityViewModel(commodityUseCase: mockCommodityUseCase)),
      ),
    ]);
  });

  test('check initial state', () {
    final commodityState = container.read(commodityViewModelProvider);
    expect(commodityState.isLoading, true);
    expect(commodityState.commodity, isEmpty);
    expect(commodityState.error, isNull);
  });

  test('get commodity and commodity length', () async {
    when(mockCommodityUseCase.getCommodity())
        .thenAnswer((realInvocation) => Future.value(Right(commodityData)));

    await container.read(commodityViewModelProvider.notifier).getCommodity();

    final commodityState = container.read(commodityViewModelProvider);

    expect(commodityState.commodity, commodityData);
  });

  test('get commodity length', () async {
    when(mockCommodityUseCase.getCommodity())
        .thenAnswer((realInvocation) => Future.value(Right(commodityData)));

    await container.read(commodityViewModelProvider.notifier).getCommodity();

    final commodityState = container.read(commodityViewModelProvider);

    expect(commodityState.commodity.length, 107);
  });
}
