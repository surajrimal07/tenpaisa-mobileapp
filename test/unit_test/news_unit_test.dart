import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/feathures/news/domain/entity/news_entity.dart';
import 'package:paisa/feathures/news/domain/usecase/news_usecase.dart';
import 'package:paisa/feathures/news/presentation/viewmodel/news_viewmodel.dart';

import '../../test_data/news_entity_test.dart';
import 'news_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NewsUseCase>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late NewsUseCase mockNewsUseCase;
  late ProviderContainer container;
  late List<NewsEntity> newsData;

  setUpAll(() async {
    mockNewsUseCase = MockNewsUseCase();
    newsData = await getNewsEntityTest();
    when(mockNewsUseCase.getNews(1))
        .thenAnswer((realInvocation) => Future.value(const Right([])));
    container = ProviderContainer(overrides: [
      newsViewModelProvider.overrideWith(
        ((ref) => NewsViewModel(newsUseCase: mockNewsUseCase)),
      ),
    ]);
  });

  test('check initial state', () {
    final stockState = container.read(newsViewModelProvider);
    expect(stockState.isLoading, true);
    expect(stockState.news, isEmpty);
  });

//throws error when running all // not sure why
//works when ran individually
  test('get news and news length', () async {
    when(mockNewsUseCase.getNews(1))
        .thenAnswer((realInvocation) => Future.value(Right(newsData)));

    await container.read(newsViewModelProvider.notifier).getNews();

    final newsState = container.read(newsViewModelProvider);

    expect(newsState.news, newsData);
    expect(newsState.news.length, 10);
  });
}
