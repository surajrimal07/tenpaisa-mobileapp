import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/feathures/home/domain/entity/index_entity.dart';
import 'package:paisa/feathures/home/domain/usecase/index_use_case.dart';
import 'package:paisa/feathures/home/presentation/viewmodel/index_view_model.dart';

import '../../test_data/index_entity_test.dart';
import 'index_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<IndexUseCase>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late IndexUseCase mockIndexUseCase;
  late ProviderContainer container;
  late List<IndexEntity> indexData;

  setUpAll(() async {
    mockIndexUseCase = MockIndexUseCase();
    indexData = await getIndexEntityTest();
    when(mockIndexUseCase.getIndex(false))
        .thenAnswer((realInvocation) => Future.value(const Right([])));
    container = ProviderContainer(overrides: [
      indexViewModelProvider.overrideWith(
        ((ref) => IndexViewModel(indexUseCase: mockIndexUseCase)),
      ),
    ]);
  });

  test('check initial state', () {
    final indexState = container.read(indexViewModelProvider);
    expect(indexState.isLoading, true);
    expect(indexState.index, isNotEmpty);
    expect(indexState.error, isNull);
  });

  test('get index and index length', () async {
    when(mockIndexUseCase.getIndex(false))
        .thenAnswer((realInvocation) => Future.value(Right(indexData)));

    await container.read(indexViewModelProvider.notifier).getIndex(false);

    final indexState = container.read(indexViewModelProvider);

    expect(indexState.index, indexData);
  });

  test('get index length', () async {
    when(mockIndexUseCase.getIndex(false))
        .thenAnswer((realInvocation) => Future.value(Right(indexData)));

    await container.read(indexViewModelProvider.notifier).getIndex(false);

    final indexState = container.read(indexViewModelProvider);

    expect(indexState.index.length, 15);
  });
}
