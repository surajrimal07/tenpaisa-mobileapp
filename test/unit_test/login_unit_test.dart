import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/usecase/login_user_usecase.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';

import 'login_unit_test.mocks.dart';
//unit test - 10

@GenerateNiceMocks(
    [MockSpec<LoginUserUseCase>(), MockSpec<NavigationService>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late LoginUserUseCase mockLoginUserUseCase;
  late NavigationService mockNavigationService;
  late ProviderContainer container;

  setUpAll(() {
    mockLoginUserUseCase = MockLoginUserUseCase();
    mockNavigationService = MockNavigationService();
    container = ProviderContainer(overrides: [
      loginUserUseCaseProvider.overrideWith(
        ((ref) => mockLoginUserUseCase),
      ),
      navigationServiceProvider.overrideWith(
        ((ref) => mockNavigationService),
      ),
    ]);
  });

  test('check aut initial state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.showMessage, false);
  });

  test('login test using valid username and password', () async {
    const authEntity = AuthEntity(
        name: 'Suraj',
        email: 'rimal',
        password: '111111',
        phone: 9840220290,
        token: 'zskxbs');
    when(mockLoginUserUseCase.loginUser('suraj', '111111', true))
        .thenAnswer((_) => Future.value(const Right(authEntity)));

    await container
        .read(authViewModelProvider.notifier)
        .signIn(container, 'suraj', '111111', true, mockNavigationService);
    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('login test using Invalid username and password', () async {
    when(mockLoginUserUseCase.loginUser('suraj', '111111', true))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid User'))));

    await container
        .read(authViewModelProvider.notifier)
        .signIn(container, 'suraj', '111111', true, mockNavigationService);
    final authState = container.read(authViewModelProvider);
    expect(authState.error, 'Invalid User');
  });

  tearDownAll(() {
    container.dispose();
  });
}
