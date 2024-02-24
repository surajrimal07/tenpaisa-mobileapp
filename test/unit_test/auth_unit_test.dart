import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paisa/feathures/auth/domain/usecase/login_user_usecase.dart';
import 'package:paisa/feathures/auth/presentation/view_model/auth_view_model.dart';

import 'auth_unit_test.mocks.dart';
import 'package:flutter_test/flutter_test.dart';

@GenerateNiceMocks([
  MockSpec<LoginUserUseCase>(),
  MockSpec<BuildContext>(),
])
void main() {
  late LoginUserUseCase mockAuthUsecase;
  late ProviderContainer container;
  late BuildContext context;

  setUpAll(() {
    mockAuthUsecase = MockLoginUserUseCase();
    context = MockBuildContext();
    container = ProviderContainer(
      overrides: [
        authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockAuthUsecase),
        ),
      ],
    );
  });

  test('check for the inital state', () async {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
    expect(authState.imageName, isNull);

  });

  // While testing this for now comment the navigation part and snackbar part
  test('login test with valid username and', () async {
    when(mockAuthUsecase.loginStudent('kiran', 'kiran123'))
        .thenAnswer((_) => Future.value(const Right(true)));

    when(mockAuthUsecase.loginStudent('kiran', 'kiran1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .loginStudent(context, 'kiran', 'kiran1234');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, isNull);
  });

  test('check for invalid username and password ', () async {
    when(mockAuthUsecase.loginStudent('kiran', 'kiran1234'))
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container
        .read(authViewModelProvider.notifier)
        .loginStudent(context, 'kiran', 'kiran1234');

    final authState = container.read(authViewModelProvider);

    expect(authState.error, 'Invalid');
  });

  tearDownAll(
    () => container.dispose(),
  );
}
