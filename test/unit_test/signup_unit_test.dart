import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/config/router/navigation_service.dart';
import 'package:paisa/core/failure/failure.dart';
import 'package:paisa/feathures/auth/domain/entity/auth_entity.dart';
import 'package:paisa/feathures/auth/domain/usecase/add_user_usecase.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';

import 'signup_unit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AddUserUseCase>(), MockSpec<NavigationService>()])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late AddUserUseCase mockAddUserUseCase;
  late NavigationService mockNavigationService;
  late ProviderContainer container;

  setUpAll(() {
    mockAddUserUseCase = MockAddUserUseCase();
    mockNavigationService = MockNavigationService();
    container = ProviderContainer(overrides: [
      addUserUseCaseProvider.overrideWith(
        ((ref) => mockAddUserUseCase),
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

  test('signup test using valid username and password', () async {
    const authEntity = AuthEntity(
        name: 'Suraj',
        email: 'rimal',
        password: '111111',
        phone: 9840220290,
        token: 'zskxbs');
    when(mockAddUserUseCase.addUser(authEntity, true))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container
        .read(authViewModelProvider.notifier)
        .signUp(authEntity, true, mockNavigationService);
    final authState = container.read(authViewModelProvider);
    expect(authState.error, isNull);
  });

  test('signup test using invalid username and password', () async {
    const authEntity = AuthEntity(
        name: 'Suraj',
        email: 'rimal',
        password: '111111',
        phone: 9840220290,
        token: 'zskxbs');
    when(mockAddUserUseCase.addUser(authEntity, true))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid Data'))));

    await container
        .read(authViewModelProvider.notifier)
        .signUp(authEntity, true, mockNavigationService);
    final authState = container.read(authViewModelProvider);
    expect(authState.error, 'Invalid Data');
  });

  tearDownAll(() {
    container.dispose();
  });
}
